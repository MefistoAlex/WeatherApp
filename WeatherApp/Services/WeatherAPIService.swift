//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation
protocol WeatherAPIServiceInterface {
    func loadWeather(parameters: WeatherRequestParameters, completion: @escaping (_ responce: WeatherInLocation?, _ error: Error?) -> Void)
}

final class WeatherAPIService: WeatherAPIServiceInterface {
    private let apiManager: APIManager

    init() {
        apiManager = AlamofireAPIManager()
    }

    func loadWeather(parameters: WeatherRequestParameters, completion: @escaping (WeatherInLocation?, Error?) -> Void) {
        apiManager.request(urlString: parameters.url,
                           method: .get,
                           dataType: WeatherRequestResponse.self,
                           headers: nil,
                           parameters: parameters.toDictionary) { responce, error in
            if let responce = responce {
                let currentWeather = WeatherInLocation(from: responce)
                completion(currentWeather, error)
            } else {
                completion(nil, error)
            }
            
        }
    }
}
