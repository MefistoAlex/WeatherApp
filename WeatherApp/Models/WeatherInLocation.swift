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


