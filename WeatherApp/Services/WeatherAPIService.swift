//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation
protocol WeatherAPIServiceInterface {
    func loadWeather(parameters: WeatherRequestParameters, completion: @escaping (_ responce: WeatherRequestResponse?, _ error: Error?) -> Void)
}

final class WeatherAPIService: WeatherAPIServiceInterface {
    private let apiManager: APIManager

    init() {
        apiManager = AlamofireAPIManager()
    }

    func loadWeather(parameters: WeatherRequestParameters, completion: @escaping (WeatherRequestResponse?, Error?) -> Void) {
        apiManager.request(urlString: parameters.url,
                           method: .get,
                           dataType: WeatherRequestResponse.self,
                           headers: nil,
                           parameters: parameters.toDictionary) { responce, error in

            completion(responce, error)
        }
    }
}
