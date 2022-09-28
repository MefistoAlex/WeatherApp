//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import CoreLocation
import MapKit
import RxCocoa
import RxSwift
import UIKit

final class MapViewController: UIViewController, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    // MARK: - Variable Declarations

    private let locationManager = LocationManager.shared
    private let weatherViewModel = WeatherViewModel.shared
    private let locationViewModel = LocationViewModel.shared
    private let disposeBag = DisposeBag()
    private var currentLocation: CLLocation?

    @IBOutlet private var mapView: MKMapView!

    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkBlue")

        locationManager.delegate = self
        currentLocation = locationManager.location
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true

        locationViewModel.pin.subscribe { mapItem in
            guard let element = mapItem.element else { return }
            let location = CLLocation(
                latitude: element.placemark.coordinate.latitude,
                longitude: element.placemark.coordinate.longitude
            )
            self.setPin(location: location)
            self.mapView.centerToLocation(location)
        }.disposed(by: disposeBag)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let locationSearchController = storyboard.instantiateViewController(withIdentifier: String(describing: LocationSearchViewController.self)) as! LocationSearchViewController
        locationSearchController.mapView = mapView
        let searchController = UISearchController(searchResultsController: locationSearchController)
        searchController.searchResultsUpdater = locationSearchController
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search for places"

        navigationItem.searchController = searchController

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

    private func setPin(location: CLLocation) {
        if !mapView.annotations.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
        }
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        pin.title = "What weather is here?"
        currentLocation = location
        mapView.addAnnotation(pin)
    }

    @objc private func mapDidTap(gestureRecognizer: UIGestureRecognizer) {
        let locationTouch = gestureRecognizer.location(in: mapView)
        let locationCoordinale = mapView.convert(locationTouch, toCoordinateFrom: mapView)
        let location = CLLocation(
            latitude: locationCoordinale.latitude,
            longitude: locationCoordinale.longitude
        )
        setPin(location: location)
    }
}

// MARK: Map View

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
