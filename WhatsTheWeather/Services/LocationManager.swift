//
//  LocationManager.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 21.04.2023.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var locationCoordinates: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationCoordinates = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
        case .restricted:
            authorizationStatus = .restricted
            print("restricted")
            break
        case .denied:
            authorizationStatus = .denied
            print("denied")
            break
        case .authorizedAlways:
            authorizationStatus = .authorizedAlways
            break
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            requestLocation()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
