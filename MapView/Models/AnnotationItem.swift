//
//  AnnotationItem.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
