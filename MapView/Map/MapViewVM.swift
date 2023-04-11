//
//  MapViewVM.swift
//  MapView
//
//  Created by Paulo Orquillo on 11/04/23.
//

import Foundation
import MapKit

enum MapDetails {
    static let defaultLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -36.848461, longitude: 174.763336)
    static let defaultSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
}

// enable property list to request usage - Privacy - Location When In Use Usage Description
// need to conform to NSObject and CLLocation Delegate
final class MapViewVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpan)
    //used to annotate the location from search
    @Published private(set) var annotationItems: [AnnotationItem] = []
    
    var locationManager: CLLocationManager? //optional 
    
    
    //func to check if user has location services enabled - changed to async to prevent background threads updating the main ui
    func checkLocationServices() async {
        if CLLocationManager.locationServicesEnabled() {
            //set up location manager
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            checkLocationAuthorization()
        } else {
            //show alert
            print("location services needs to be enabled")
        }
    }


    //func to check location authorization
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {  
        case .denied:
            print("permission denied,. please turn on location for this feature")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("please turn on location for this feature")
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            // changed to dispatchqueue to make the changes in the main thread
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
            }
        @unknown default:
            break
        }
    }

    //using mklocalsearch

    func getPlace(from address: AddressResult) {
        let searchRequest = MKLocalSearch.Request()
        let title = address.title
        let subTitle = address.subtitle
        searchRequest.naturalLanguageQuery = subTitle.contains(title) ? subTitle : title + ", " + subTitle
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print(error?.localizedDescription ?? "error")
                return
            }
            let mapItem = response.mapItems[0]
            let placemark = mapItem.placemark
            let coordinate = placemark.coordinate
            let annotation = AnnotationItem(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
            DispatchQueue.main.async {
                self.annotationItems.append(annotation)
            }
        }
    }
}
