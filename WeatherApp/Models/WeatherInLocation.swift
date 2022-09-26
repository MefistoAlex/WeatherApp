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
