//
//  AnnotationData.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import Foundation
import MapKit

struct AnnotationData: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
