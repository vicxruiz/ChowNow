//
//  LocationDetailView.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    private enum Constants {
        static let mapViewHeight: CGFloat = 450
        static let mapViewCornerRadius: CGFloat = 32
    }
    @ObservedObject private var viewModel: LocationDetailViewModel
    @State private var region: MKCoordinateRegion = .init()
    @State private var selection: Int = 0
    
    init(viewModel: LocationDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    mapView
                }
                Section(Strings.LocationDetail.about) {
                    aboutView
                }
                Section(Strings.LocationDetail.cuisines) {
                    ForEach(viewModel.location.cuisines, id: \.self) { cuisine in
                        Text(cuisine)
                    }
                }
                Section(Strings.LocationDetail.pickup) {
                    pickupView
                }
            }
            .listStyle(.insetGrouped)
        }
        .onReceive(viewModel.$region.map { $0 }, perform: { result in
            region = result
        })
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.trigger(.updateRegion)
        }
    }
    
    var mapView: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.annotations) {
            MapMarker(coordinate: $0.coordinate)
        }
        .frame(height: Constants.mapViewHeight)
        .clipShape(RoundedRectangle(cornerRadius: Constants.mapViewCornerRadius))
        .ignoresSafeArea(edges: .top)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    var aboutView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.location.name)
                .font(.headline)
                .fontWeight(.bold)
            Text(viewModel.location.address.formattedAddress)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("Call: \(viewModel.location.phone)")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
    
    var pickupView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Layout.pd100) {
                ForEach(viewModel.location.fulfillment.pickup.displayHours, id: \.self) { displayHour in
                    let dayOfWeek = displayHour.dow
                    let ranges = displayHour.ranges
                    VStack(alignment: .leading) {
                        Text(dayOfWeek)
                            .font(.headline)
                            .padding(.vertical, Layout.pd25)
                        
                        ForEach(ranges, id: \.self) { timeRange in
                            Text("\(timeRange.from) - \(timeRange.to)")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, Layout.pd100)
        }
    }
}
