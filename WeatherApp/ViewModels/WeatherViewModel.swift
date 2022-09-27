//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 26.09.2022.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

final class WeatherViewModel {
    
   static let shared: WeatherViewModel = {
        WeatherViewModel()
    }()
    
    private init(){}
    
    var city = PublishSubject<String>()
    var dailyWeather = PublishSubject<[DailyWeather]>()
    var currentForecast = PublishSubject<WeatherDetailsData>()
    var currentDayWeather = PublishSubject<[WeatherDetailsData]>()

    private lazy var weatherService: WeatherAPIServiceInterface = {
        WeatherAPIService()
    }()

    private var locationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }

        return locationManager
    }()

    func fetchItem() {
        let curentLocation = locationManager.location
        if let curentLocation = curentLocation {
            let parameters = WeatherRequestParameters(latitude: curentLocation.coordinate.latitude, longitude: curentLocation.coordinate.longitude)
            weatherService.loadWeather(parameters: parameters) { responce, _ in
                guard let responce = responce else { return }
                self.dailyWeather.onNext(responce.weatherByDays)
                self.city.onNext(responce.city)
                self.currentForecast.onNext(responce.weatherByDays[0].details[0])
                self.currentDayWeather.onNext(responce.weatherByDays[0].details)
            }
        }
    }
}
