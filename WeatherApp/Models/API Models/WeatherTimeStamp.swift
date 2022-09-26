//
//  WeatherTimeStamp.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation
struct WeatherTimeStamp: Codable {
    let dt: Int
    let main: Temperature
    let wind: Wind
    let weather: [Weather]
    let dt_txt : String
}
