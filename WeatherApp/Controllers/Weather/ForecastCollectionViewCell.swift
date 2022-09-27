//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import UIKit

final class ForecastCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var weatherIconImage: UIImageView!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    func setForecastWeather(_ forecast: WeatherDetailsData ) {
        timeLabel.text = "\(forecast.hour):00"
        weatherIconImage.image = UIImage(named: forecast.weatherIcon.rawValue)
        tempLabel.text = "\(forecast.temp)°C"
    }
}
