//
//  MarkerAnnotationView.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import Foundation
import MapKit

class MarkerAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
//            guard let companyAnnotation = newValue as? CompanyAnnotation else {
//                return
//            }
            clusteringIdentifier = "companyClusterIdentifier"
            
            glyphImage = UIImage(systemName: "building.2")
            markerTintColor = UIColor.blue
        }
    }
}
