//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 21.09.2022.
//

import CoreLocation
import RxCocoa
import RxSwift
import UIKit

final class WeatherViewController: UIViewController {
    private let weatherViewModel = WeatherViewModel()
    private var disposeBag = DisposeBag()

    // MARK: Outlets

    @IBOutlet private var currentDayLabel: UILabel!
    @IBOutlet private var currentWeatherImage: UIImageView!
    @IBOutlet private var currentTempLabel: UILabel!
    @IBOutlet private var currentHumidityLabel: UILabel!
    @IBOutlet private var currentWindDirectionImage: UIImageView!
    @IBOutlet private var currentWindSpeed: UILabel!
    @IBOutlet private var tableView: UITableView!

    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkBlue")

        // set left bar button
        weatherViewModel.city.subscribe { cityName in
            let placeButton = UIButton(type: .system)
            placeButton.setImage(UIImage(named: NavigationImages.place.rawValue), for: .normal)
            placeButton.setTitle(" " + String(cityName), for: .normal)
            placeButton.sizeToFit()
            placeButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
            placeButton.isEnabled = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: placeButton)
        }.disposed(by: disposeBag)

        // set right bar button
        let locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(named: NavigationImages.location.rawValue), for: .normal)
        locationButton.sizeToFit()
        locationButton.addTarget(self, action: #selector(locationSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: locationButton)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()

        weatherViewModel.currentDayWeather.subscribe { dailyWeather in
            if let element = dailyWeather.element {
                self.currentDayLabel.text = element.day
                self.currentHumidityLabel.text = "\(element.humidity)"
                self.currentTempLabel.text = "\(element.temp)°C"
                self.currentWindSpeed.text = "\(element.windSpeed)"
                self.currentWindDirectionImage.image = UIImage(named: element.windDirection.rawValue)
                self.currentWeatherImage.image = UIImage(named: element.weatherIcon.rawValue)
            }
        }.disposed(by: disposeBag)

        bindTableData()
    }

    private func bindTableData() {
        // bind items to the table
        weatherViewModel.dailyWeather.bind(
            to: tableView.rx.items(
                cellIdentifier: String(describing: DailyWeatherTableViewCell.self),
                cellType: DailyWeatherTableViewCell.self)
        ) { _, item, cell in
            cell.setDayWeather(dailyWeather: item)
        }.disposed(by: disposeBag)

        // bind a model selected hendler

        tableView.rx.modelSelected(DailyWeather.self).bind { dailyWeather in
            self.weatherViewModel.currentDayWeather.onNext(dailyWeather.details[0])
            self.weatherViewModel.currentDayWeather.onCompleted()
        }.disposed(by: disposeBag)

        // fetch items
        weatherViewModel.fetchItem()
    }

    @objc private func locationSearch() {
        let storyboaard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboaard.instantiateViewController(withIdentifier: String(describing: MapViewController.self)) as! MapViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}
