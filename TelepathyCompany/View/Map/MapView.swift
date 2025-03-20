//
//  MapView.swift
//  TelepathyCompany
//
//  Created by james on 2/16/25.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var annotations: [CompanyAnnotation]?
    var viewModel: CompaniesViewModel?
    
    private let mkMapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.showsCompass = false
        return map
    }()
    
    // MARK: UIViewRepresentable protocol
    func makeUIView(context: Context) -> MKMapView {
        registerAnnotationViewClasses()
        mkMapView.delegate = context.coordinator
        
        let trackingButton = MKUserTrackingButton(mapView: mkMapView)
        trackingButton.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        trackingButton.layer.borderColor = UIColor.white.cgColor
        trackingButton.layer.borderWidth = 1
        trackingButton.layer.cornerRadius = 8
        trackingButton.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(trackingButton)
        
        let compassButton = MKCompassButton(mapView: mkMapView)
        compassButton.compassVisibility = .adaptive // 나침반 항상 보이도록 설정
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(compassButton)
        
//        let scale = MKScaleView(mapView: mkMapView)
//        scale.legendAlignment = .trailing
//        scale.translatesAutoresizingMaskIntoConstraints = false
//        mkMapView.addSubview(scale)
        
        NSLayoutConstraint.activate([
            trackingButton.bottomAnchor.constraint(equalTo: mkMapView.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            trackingButton.trailingAnchor.constraint(equalTo: mkMapView.trailingAnchor, constant: -10),
            trackingButton.widthAnchor.constraint(equalToConstant: 40),
            trackingButton.heightAnchor.constraint(equalToConstant: 40),
            
            compassButton.topAnchor.constraint(equalTo: trackingButton.bottomAnchor, constant: 10),
            compassButton.trailingAnchor.constraint(equalTo: trackingButton.trailingAnchor),
            compassButton.widthAnchor.constraint(equalToConstant: 40),
            compassButton.heightAnchor.constraint(equalToConstant: 40),
            
//            scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
//            scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return mkMapView
    }
    
    // MARK: UIViewRepresentable protocol
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        guard let annotations = annotations, viewModel?.isRefreshed ?? false else {
            return
        }
        viewModel?.isRefreshed.toggle()
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
    // MARK: UIViewRepresentable protocol
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self,
                                   locationManager: CLLocationManager())
    }
    
    func registerAnnotationViewClasses() {
        mkMapView.register(MarkerAnnotationView.self,
                           forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mkMapView.register(ClusterAnnotationView.self,
                           forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
}

extension MapView : MapViewProtocol {
    
    func setRegion(_ region: MKCoordinateRegion,
                   needUpdate: Bool,
                   animated: Bool) {
        viewModel?.regionTuple = (region.center.latitude, region.center.longitude)
        if needUpdate {
            mkMapView.setRegion(region, animated: animated)
            viewModel?.requestCompaniesAPI()
        }
    }
}

//#Preview {
//    BindingPreviewWrapper()
//}
//
//struct BindingPreviewWrapper: View {
//    @State private var annoss: [CompanyAnnotation]? = [
//        CompanyAnnotation(company: Company(code: AnyIntValue.int(1),
//                                           name: "",
//                                           addr: "",
//                                           type: "",
//                                           intro: "",
//                                           welfare: "",
//                                           img: "",
//                                           lat: AnyDoubleValue.double(37.14),
//                                           lng: AnyDoubleValue.double(103.22),
//                                           jobs: [Job(id: 1,
//                                                      title: "",
//                                                      detail: "",
//                                                      responsibilities: "",
//                                                      requirements: "",
//                                                      preferred: "")]))
//    ]
//
//    var body: some View {
//        MapView(annotations: $annoss)
//    }
//}
