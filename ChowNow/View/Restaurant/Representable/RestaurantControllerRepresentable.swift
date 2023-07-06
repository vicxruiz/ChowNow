//
//  LocationListControllerRepresentable.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import SwiftUI

struct RestaurantControllerRepresentable: UIViewControllerRepresentable {
    var viewModel: RestaurantViewModel
    func makeUIViewController(context: Context) -> RestaurantViewController {
        return RestaurantViewController(viewModel: viewModel)
    }

    func updateUIViewController(
        _ uiViewController: RestaurantViewController, context: Context
    ) {}
}
