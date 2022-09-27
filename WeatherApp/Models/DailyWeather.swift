//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import Foundation

struct DailyWeather {
    let date: Date
    let details: [WeatherDetailsData]

    //MARK: Computed properties
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: date)
    }

    var minmaxTemp: String {
        let minTemp = details.min { $0.tempMin < $1.tempMin }?.tempMin
        let maxTemp = details.max { $0.tempMax < $1.tempMax }?.tempMax
        if let minTemp = minTemp, let maxTemp = maxTemp {
            return "\(Int(maxTemp.rounded(.toNearestOrEven)))°/\(Int(minTemp.rounded(.toNearestOrEven)))°"
        } else {
            return ""
        }
    }

    var modeWeather: WeatherIcons {
        let weatherIdArray = details.map { $0.weatherId }
        var counterDict: [Int: Int] = [:]
        for id in weatherIdArray {
            if let oldVal = counterDict[id] {
                counterDict[id] = oldVal + 1
            } else {
                counterDict[id] = 1
            }
        }
        var returnArray: [Int] = []
        if let max = counterDict.values.max() {
            for pair in counterDict {
                if pair.value == max {
                    returnArray.append(pair.key)
                }
            }
        }
        if let result = returnArray.first {
            let icon = details.filter { $0.weatherId == result }.first?.weatherIcon
            return icon ?? .brigthDay
        } else {
            return .brigthDay
        }
    }
}
