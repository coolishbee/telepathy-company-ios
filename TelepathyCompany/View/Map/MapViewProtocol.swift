//
//  MapViewProtocol.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import Foundation
import MapKit

protocol MapViewProtocol {
    var viewModel: CompaniesViewModel? { get set }
    func setRegion(_ region: MKCoordinateRegion, needUpdate: Bool, animated: Bool)
}
