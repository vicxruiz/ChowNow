//
//  LocationDetailViewModel.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import Combine
import MapKit

final class LocationDetailViewModel: ObservableObject {
    enum Input {
        case updateRegion
    }
    
    /**
     Initializes the LocationDetailViewModel.
     - Parameters:
     - location: The location object used for updating view.
     */
    init(
        location: Location
    ) {
        self.location = location
    }
    
    let location: Location
    var annotations: [AnnotationData] = []
    
    
    @Published var centerLocation: Location?
    @Published var region: MKCoordinateRegion = .init()

    func trigger(_ input: Input) {
        switch input {
        case .updateRegion: updateRegion()
        }
    }
    
    private func updateRegion() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: location.address.latitude, longitude: location.address.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let coordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        DispatchQueue.main.async {
            self.annotations = [AnnotationData(coordinate: centerCoordinate)]
            self.region = coordinateRegion
        }
    }
}
