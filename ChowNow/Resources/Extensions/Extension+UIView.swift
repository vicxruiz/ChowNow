//
//  ChowNow+Extensions.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import UIKit

extension UIView {
    convenience init(subview: UIView) {
        self.init(frame: .zero)
        self.addSubview(subview)
    }
}

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

extension UICollectionView {
    final func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type = T.self, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the" +
                " cell is registered with table view"
            )
        }
        return cell
    }

    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
}
