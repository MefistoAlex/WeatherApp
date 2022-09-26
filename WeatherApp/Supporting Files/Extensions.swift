//
//  Extensions.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 22.09.2022.
//

import Foundation
enum NavigationImages: String {
    case place = "ic_place"
    case location = "ic_my_location"
    case search = "ic_search"
    case back = "ic_back"
}

enum WindDirection: String {
    case west = "icon_wind_w"
    case northWest = "icon_wind_wn"
    case north = "icon_wind_n"
    case northEast = "icon_wind_ne"
    case east = "icon_wind_e"
    case southEast = "icon_wind_se"
    case south = "icon_wind_s"
    case southWest = "icon_wind_ws"
}

enum WeatherIcons: String {
    case brigthDay = "ic_white_day_bright"
    case cloudyDay = "ic_white_day_cloudy"
    case rainDay = "ic_white_day_rain"
    case showerDay = "ic_white_day_shower"
    case thunderDay = "ic_white_day_thunder"
    case brigthNight = "ic_white_night_bright"
    case cloudyNight = "ic_white_night_cloudy"
    case rainNight = "ic_white_night_rain"
    case showerNight = "ic_white_night_shower"
    case thunderNight = "ic_white_night_thunder"
}
