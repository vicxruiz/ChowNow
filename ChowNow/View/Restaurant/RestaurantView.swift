//
//  LocationListView.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import SwiftUI

struct RestaurantView: View {
    @ObservedObject var viewModel = RestaurantViewModel()
    var body: some View {
        makeBody()
    }
    
    func makeBody() -> some View {
        NavigationStack {
            VStack {
                RestaurantControllerRepresentable(viewModel: viewModel)
            }
            .navigationTitle(Strings.Locations.locations)
            .navigationDestination(isPresented: $viewModel.showDetail, destination: {
                if let location = viewModel.selectedLocation {
                    let viewModel = LocationDetailViewModel(location: location)
                    LocationDetailView(viewModel: viewModel)
                }
            })
        }
    }
}
