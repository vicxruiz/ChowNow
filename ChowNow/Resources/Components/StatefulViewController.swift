//
//  StatefulViewController.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import SnapKit
import UIKit

enum ViewState: Equatable {
    case content
    case loading
    case error(BasicError)
}

//Base view controller
//a stateful view controller refers to a view controller that manages and maintains its own state throughout its lifecycle.
class StatefulViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let transitionDuration: TimeInterval = 0.3
    }

    // MARK: - Properties

    public var viewState: ViewState = .content {
        didSet {
            transitionToViewState(animated: true)
        }
    }
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        return view
    }()

    private lazy var contentWrapper = UIView()

    public var content: UIView? {
        didSet {
            oldValue?.removeFromSuperview()

            guard let content = content else {
                return
            }

            contentWrapper.addSubview(content)

            content.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }

    private lazy var contentView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [contentWrapper], axis: .vertical)
        view.isHidden = true
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(contentView)
        view.addSubview(loadingView)
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        setConstraints()
        transitionToViewState(animated: false)
    }

    // MARK: - Helpers

    private func transitionToViewState(animated: Bool) {
        if case .error(let error) = viewState {
            showAlert(with: error)
            return
        }

        let swapActiveView = { [self] in
            loadingView.isHidden = true
            contentView.isHidden = true

            switch viewState {
            case .loading:
                loadingView.isHidden = false
            case .content:
                contentView.isHidden = false
            case .error:
                break
            }
        }

        if animated {
            UIView.transition(
                with: containerView,
                duration: Constants.transitionDuration,
                options: [.transitionCrossDissolve, .curveEaseInOut],
                animations: swapActiveView
            )
        } else {
            swapActiveView()
        }
    }

    private func setConstraints() {
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func showAlert(with error: BasicError) {
        let alertController = UIAlertController(
            title: error.title,
            message: error.message,
            preferredStyle: .alert
        )

        let okayAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )

        alertController.addAction(okayAction)

        present(alertController, animated: true, completion: nil)
    }
}

