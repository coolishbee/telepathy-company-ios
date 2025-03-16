//
//  CLLocation+Distance.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import MapKit

extension CLLocation {
    
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return to.distance(from: from)
    }
}
