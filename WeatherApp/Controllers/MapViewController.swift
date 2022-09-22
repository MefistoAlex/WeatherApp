//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import CoreLocation
import MapKit
import UIKit

final class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Variable Declarations

    var locationManager: CLLocationManager!
    var currentLocationStr = "Current location"
    @IBOutlet private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "DarkBlue")

        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapDidTap))
        mapView.addGestureRecognizer(tapGesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            if let  location = locationManager.location {
                mapView.centerToLocation(location)
            } 
        }
    }

    @objc private func mapDidTap(gestureRecognizer: UIGestureRecognizer) {
        if !mapView.annotations.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
        }
        let locationTouch = gestureRecognizer.location(in: mapView)
        let locationCoordinale = mapView.convert(locationTouch, toCoordinateFrom: mapView)
        let pin = MKPointAnnotation()
        pin.coordinate = locationCoordinale
        pin.title = "What weather is here?\n" + setUsersClosestLocation(mLattitude: locationCoordinale.latitude, mLongitude: locationCoordinale.longitude)
        mapView.addAnnotation(pin)
    }

    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            placemarks, _ in
            if let mPlacemark = placemarks {
                if let dict = mPlacemark[0].addressDictionary as? [String: Any] {
                    if let Name = dict["Name"] as? String {
                        if let City = dict["City"] as? String {
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
