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
    private let locationManager = LocationManager.shared
    private let weatherViewModel = WeatherViewModel.shared
    private let searchController = UISearchController()
    private var currentLocation: CLLocation?
    
    @IBOutlet private var mapView: MKMapView!
    
    //MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkBlue")

        currentLocation = locationManager.location
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true

        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController

        // set right bar button
        let seaarhcButton = UIButton(type: .system)
        seaarhcButton.setImage(UIImage(named: NavigationImages.search.rawValue), for: .normal)
        seaarhcButton.sizeToFit()
        seaarhcButton.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: seaarhcButton)

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapDidTap))
        mapView.addGestureRecognizer(tapGesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        if let location = locationManager.location {
            mapView.centerToLocation(location)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        weatherViewModel.fetchWeather(in: currentLocation)
    }

    @objc private func searchButtonDidTap() {
    }

    @objc private func mapDidTap(gestureRecognizer: UIGestureRecognizer) {
        if !mapView.annotations.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
        }
        let locationTouch = gestureRecognizer.location(in: mapView)
        let locationCoordinale = mapView.convert(locationTouch, toCoordinateFrom: mapView)
        let pin = MKPointAnnotation()
        pin.coordinate = locationCoordinale
        pin.title = "What weather is here?"
        let location = CLLocation(
            latitude: locationCoordinale.latitude,
            longitude: locationCoordinale.longitude
        )
        currentLocation = location
        mapView.addAnnotation(pin)
//        mapView.centerToLocation(location)
    }

    func setUsersClosestLocation(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lattitude, longitude: longitude)
        var currentLocationStr:String = ""
        geoCoder.reverseGeocodeLocation(location) {
            placemarks, _ in
            if let mPlacemark = placemarks {
                if let dict = mPlacemark[0].addressDictionary as? [String: Any] {
                    if let Name = dict["Name"] as? String {
                        if let City = dict["City"] as? String {
                            currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
}

//MARK: Map View 

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

// MARK: Search Results Updating

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("search")
    }
}
