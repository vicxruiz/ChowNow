//
//  LocationCell.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit
import SnapKit

/// Custom cell for displaying location information
///
/// Given more time, I would try to abstract some of these views into more reusable components
final class LocationCell: BaseCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let divideLineHeight: CGFloat = 0.7
    }
    
    // MARK: - Private Properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()

    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Layout.pd75)
        label.textColor = .darkGray
        return label
    }()

    private lazy var dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var contentStack: UIStackView = {
       let stackView = UIStackView(
            arrangedSubviews: [
                nameLabel,
                addressLabel,
                dividerLineView,
                phoneLabel
            ],
            axis: .vertical,
            spacing: Layout.pd50
        )
        
        stackView.distribution = .fill
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Layout.pd100,
            leading: Layout.pd100,
            bottom: Layout.pd100,
            trailing: Layout.pd100
        )
        
        stackView.setCustomSpacing(Layout.pd150, after: addressLabel)
        stackView.setCustomSpacing(Layout.pd75, after: dividerLineView)
        
        return stackView
    }()
    
    // MARK: Initializer
    
    /// Initializes the cell with the specified frame.
    /// - Parameter frame: The frame rectangle for the cell, measured in points.
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(contentStack)
        
        setupViewsAndConstraints()
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        addressLabel.text = nil
        phoneLabel.text = nil
    }
    
    // MARK: - Public Methods

    /// Sets the location information for the cell.
    /// - Parameter location: The location object containing the data to display.
    func set(_ location: Location) {
        nameLabel.text = location.name
        addressLabel.text = location.address.formattedAddress
        phoneLabel.text = "Call Now: \(location.phone)"
    }

    // MARK: - Private Helpers
    private func setupViewsAndConstraints() {
        dividerLineView.snp.makeConstraints { make in
            make.height.equalTo(Constants.divideLineHeight)
        }

        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Unavailable
    
    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
