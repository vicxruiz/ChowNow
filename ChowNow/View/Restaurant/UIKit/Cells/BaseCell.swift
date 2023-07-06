//
//  BaseCell.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit

/// Base cell
class BaseCell: UICollectionViewCell {
    enum Constants {
        static let borderWidth: CGFloat = 0.4
        static let cornerRadius: CGFloat = 16
    }

    // MARK: Initializer
    
    /// Initializes the cell with the specified frame.
    /// - Parameter frame: The frame rectangle for the cell, measured in points.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        applyBorder()
    }

    private func applyBorder() {
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = Constants.borderWidth
    }


    // MARK: - Unavailable
    @available(*, unavailable)
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
