//
//  LocationCoordinator.swift
//  TelepathyCompany
//
//  Created by james on 3/3/25.
//

import Foundation
import MapKit

class LocationCoordinator: NSObject {
    var mainMapView: MapViewProtocol
    var locationManager: CLLocationManager?
    
    fileprivate var beforeRegion: MKCoordinateRegion?
    
    init(mapView: MapViewProtocol, locationManager: CLLocationManager? = nil) {
        self.mainMapView = mapView
        self.locationManager = locationManager
        super.init()
        initLocationManager()
    }
    
    private func initLocationManager() {
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

//TODO: https://stackoverflow.com/questions/73805219/main-thread-warning-with-cllocationmanager-locationservicesenabled
    func checkUserDeviceLocationServiceAuthorization(_ status: CLAuthorizationStatus) {
                
        switch status {
        case .restricted:
            break
        case .denied:
            self.mainMapView.viewModel?.showMapAlert.toggle()
            return
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            return
        case .authorizedAlways:
            self.locationManager?.allowsBackgroundLocationUpdates = true
            self.locationManager?.pausesLocationUpdatesAutomatically = false
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
        self.locationManager?.startUpdatingLocation()
    }
}

extension LocationCoordinator: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserDeviceLocationServiceAuthorization(status)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last, let locationManager = self.locationManager else {
            return
        }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                               longitudeDelta: 0.01))
        self.mainMapView.setRegion(region, needUpdate: true, animated: false)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: any Error) {
        
    }
}

//MARK: - MKMapViewDelegate Delegate
extension LocationCoordinator: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        print("didSelect")
        if let annotation = view.annotation as? CompanyAnnotation {
            print("picking: \(annotation.title ?? "") : \(annotation.subtitle ?? "")")
            self.mainMapView.viewModel?.selectedAnnotation = annotation
        }
    }
    
    func mapView(_ mapView: MKMapView,
                 didDeselect view: MKAnnotationView) {
        print("didDeselect")
        self.mainMapView.viewModel?.selectedAnnotation = nil
    }
    
    func mapView(_ mapView: MKMapView,
                 regionDidChangeAnimated animated: Bool)
    {
        if let center = beforeRegion?.center {
            let distance = CLLocation.distance(from: center, to: mapView.region.center)
            if distance > 1000 {
                self.mainMapView.setRegion(mapView.region,
                                           needUpdate: false,
                                           animated: false)
            }
        }
        beforeRegion = mapView.region
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl)
    {
        if let annotation = view.annotation as? CompanyAnnotation {
            
            print("Annotation: \(annotation.title ?? "") : \(annotation.subtitle ?? "")")
            self.mainMapView.viewModel?.selectedAnnotation = annotation
            
        } else if let cluster = view.annotation as? MKClusterAnnotation {
            
            print("Annotations count: \(cluster.memberAnnotations.count)")
            self.mainMapView.viewModel?.selectedAnnotations = cluster.memberAnnotations as? [CompanyAnnotation]
        }
    }
}
