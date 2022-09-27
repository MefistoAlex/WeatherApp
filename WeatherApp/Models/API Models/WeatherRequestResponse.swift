//
//  WeatherRequestResponse.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation

struct WeatherRequestResponse: Codable {
    let cod: String
    let message: Int
    let list: [WeatherTimeStamp]
    let city: City

    struct City: Codable {
        let name: String
    }

    struct WeatherTimeStamp: Codable {
        let dt: Int
        let main: Temperature
        let wind: Wind
        let weather: [Weather]
        let dt_txt: String
    }

    struct Temperature: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int

        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }

    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
    }
}
