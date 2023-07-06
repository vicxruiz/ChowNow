//
//  ChowNow+Extensions.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView] = [],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat? = nil,
                     layoutMargins: UIEdgeInsets? = nil) {
        self.init(frame: .zero)

        add(views: arrangedSubviews)

        self.axis = axis
        self.translatesAutoresizingMaskIntoConstraints = false

        if let spacing = spacing {
            self.spacing = spacing
        }

        if let layoutMargins = layoutMargins {
            self.layoutMargins = layoutMargins
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    func add(views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

extension UITableView {
    /// Dequeue reusable UITableViewCell using class name for indexPath.
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    final func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type = T.self, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell" +
                " is registered with table view."
            )
        }
        return cell
    }

    /// Register reusable UITableViewCell using class name for reuseID.
    ///
    /// - Parameters:
    ///     - cellType: UITableViewCell type
    final func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
}

import SwiftUI

extension View {
    
    /// Pushes a view to the navigation stack.
    ///
    /// - Parameters:
    ///   - isActive: Whether the navigation link is active.
    ///   - content: The content to be pushed.
    ///
    func push<Content: View>(
        isActive: Binding<Bool>,
        @ViewBuilder to content: () -> Content
    ) -> some View {
        ZStack {
            self
            SwiftUI.NavigationLink(
                isActive: isActive
            ) {
                content()
            } label: {
                Text("Push View")
            }
            .isDetailLink(false)
            .hidden()
        }
    }
}
