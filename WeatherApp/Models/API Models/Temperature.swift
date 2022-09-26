//
//  Temperature.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation
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
