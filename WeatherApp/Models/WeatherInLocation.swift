//
//  WeatherInLocation.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 26.09.2022.
//

import Foundation

struct WeatherInLocation {
    let city: String
    let weatherByDays: [DailyWeather]

    init(from weatherRequestResponce: WeatherRequestResponse) {
        city = weatherRequestResponce.city.name
        var dailyWeatherArray = [DailyWeather]()
        var weatherDataArray = [WeatherDetailsData]()
        let calendar = Calendar.current
        var dayStart = calendar.startOfDay(for: Date())

        for weatherTimeStamp in weatherRequestResponce.list {
            let weatherDetails = WeatherDetailsData(from: weatherTimeStamp)
            let currentDayStart = calendar.startOfDay(for: weatherDetails.date)

            if dayStart == currentDayStart {
                weatherDataArray.append(weatherDetails)
            } else {
                dailyWeatherArray.append(DailyWeather(date: dayStart, details: weatherDataArray))
                weatherDataArray.removeAll()
                dayStart = currentDayStart
                weatherDataArray.append(weatherDetails)
            }
        }
        weatherByDays = dailyWeatherArray
    }
}

struct DailyWeather {
    let date: Date
    let details: [WeatherDetailsData]

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

    var modeWeather: Int {
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
            return result
        } else {
            return 0
        }
    }
}

struct WeatherDetailsData {
    let date: Date
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let weatherId: Int
    let windSpeed: Double
    let windDeg: Int

    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, d MMM"
        return dateFormatter.string(from: date)
    }

    var windDirection: WindDirection {
        switch windDeg {
        case 22 ... 67:
            return .northWest
        case 68 ... 112:
            return .north
        case 113 ... 158:
            return .northEast
        case 159 ... 204:
            return .east
        case 205 ... 250:
            return .southEast
        case 251 ... 296:
            return .south
        case 297 ... 342:
            return .southWest
        case 0 ... 21, 343 ... 360:
            return .west
        default:
            return .north
        }
    }

    init(from weatherTimeStamp: WeatherTimeStamp) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
        date = dateFormatter.date(from: weatherTimeStamp.dt_txt) ?? Date()
        temp = weatherTimeStamp.main.temp
        tempMin = weatherTimeStamp.main.tempMin
        tempMax = weatherTimeStamp.main.tempMax
        humidity = weatherTimeStamp.main.humidity
        weatherId = weatherTimeStamp.weather.first?.id ?? 0
        windSpeed = weatherTimeStamp.wind.speed
        windDeg = weatherTimeStamp.wind.deg
    }

    var hour: Int {
        Calendar.current.component(.hour, from: date)
    }
}
