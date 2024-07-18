//
//  CloudLocationManager.swift
//  CloudKitchen
//
//  Created by E5000745 on 09/07/24.
//

import Foundation
import CoreLocation
class CloudLocationManager: NSObject {
    static let shared = CloudLocationManager()
    private let locationManager = CLLocationManager()
    private var didUpdateCallback: (((latitude: Double, longitude: Double)) -> Void)?
    func getLocation(_ callback: @escaping ((latitude: Double, longitude: Double)) -> Void) {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        didUpdateCallback = callback
        locationManager.startUpdatingLocation()
    }
    func getCityName(latitude: Double, longitude: Double, completionHandler: @escaping (LocationModel) -> Void) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { (placeMarks, error) in
            if let placeMark = placeMarks?.first {
                let geoLocation = LocationModel(with: placeMark)
                geoLocation.coordinates = (latitude, longitude)
                completionHandler(geoLocation)
            }
        }
    }
}
extension CloudLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        didUpdateCallback?((location?.coordinate.latitude ?? 0, location?.coordinate.longitude ?? 0))
        locationManager.stopUpdatingLocation()
    }
}

extension LocationModel {
    convenience init(with placemark: CLPlacemark) {
        self.init()
        self.houseNo = placemark.name ?? ""
        self.addressLine1 = placemark.thoroughfare ?? ""
        self.addressLine2 = placemark.subThoroughfare ?? ""
        self.city = placemark.locality ?? ""
        self.state = placemark.administrativeArea ?? ""
        self.pincode = placemark.postalCode ?? ""
        self.country = placemark.country ?? ""
    }
}
