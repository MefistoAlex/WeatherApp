//
//  DailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 26.09.2022.
//

import UIKit

final class DailyWeatherTableViewCell: UITableViewCell {
    @IBOutlet private var dayTempLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var weatherImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            tintColor = UIColor(named: Colors.blue.rawValue)
        } else {
            tintColor = .black
        }
    }

    func setDayWeather(dailyWeather: DailyWeather) {
        dayLabel.text = dailyWeather.dayOfWeek
        dayTempLabel.text = dailyWeather.minmaxTemp
        weatherImage.image = UIImage(named: dailyWeather.modeWeather.rawValue)
    }
}
