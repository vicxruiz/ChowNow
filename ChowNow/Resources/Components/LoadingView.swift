//
//  LoadingView.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit
import SnapKit

final class LoadingView: UIView {

    // MARK: - Properties

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }()

    // MARK: - Initialization

    public init() {
        super.init(frame: .zero)
        addSubview(activityIndicator)
        setConstraints()
    }

    // MARK: - Layout

    private func setConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - Unavailable

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
