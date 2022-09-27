//
//  WeatherDetailsData.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import Foundation

struct WeatherDetailsData {
    let date: Date
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let weatherId: Int
    let windSpeed: Double
    let windDeg: Int

    // MARK: init from API model

    init(from weatherTimeStamp: WeatherRequestResponse.WeatherTimeStamp) {
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

    // MARK: Computed properties

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

    var weatherIcon: WeatherIcons {
        let isDay: Bool = 6 ... 21 ~= hour // time interval frow 21.00 to 6.00 is night

        switch weatherId {
        // thunder
        case 200 ... 232:
            return isDay ? .thunderDay : .thunderNight
        // drizzle
        case 300 ... 302, 310, 311:
            return isDay ? .rainDay : .rainNight
        case 312 ... 321:
            return isDay ? .showerDay : .showerNight
        // rain
        case 500, 501:
            return isDay ? .rainDay : .rainNight
        case 502 ... 504, 520 ... 522, 531:
            return isDay ? .showerDay : .showerNight
        // brigth
        case 800:
            return isDay ? .brigthDay : .brigthNight
        // cloudy
        case 801 ... 804:
            return isDay ? .cloudyDay : .cloudyNight

        default: return .brigthDay
        }
        // https://openweathermap.org/weather-conditions
    }

    var hour: Int {
        Calendar.current.component(.hour, from: date)
    }
}
