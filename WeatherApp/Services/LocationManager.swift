//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import CoreLocation
import Foundation

final class LocationManager {
    static let shared: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        return locationManager
    }()

    private init() {}
}
