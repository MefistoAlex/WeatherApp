//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import CoreLocation
import Foundation
import MapKit
import RxCocoa
import RxSwift

final class LocationViewModel {
    static let shared: LocationViewModel = {
        LocationViewModel()
    }()

    private init() {}

    var locations = PublishSubject<[MKMapItem]>()
    var pin = PublishSubject<MKMapItem>()

    func searchRequest(text: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.resultTypes = .address
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.locations.onNext(response.mapItems)
        }
    }
}
