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
}
