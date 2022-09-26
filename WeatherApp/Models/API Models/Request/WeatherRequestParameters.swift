//
//  WeatherRequestParameters.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation
struct WeatherRequestParameters {
    let latitude: Double
    let longitude: Double
    let language: String = "en"
    var url: String {
        "https://api.openweathermap.org/data/2.5/forecast"
    }

    var toDictionary: [String: Any] {
        [
            "lat": String(latitude),
            "lon": String(longitude),
            "appid": "997bcc6034d4a1cb7646db398555b7b1",
            "lang": language,
            "units": "metric",
        ]
    }
}
