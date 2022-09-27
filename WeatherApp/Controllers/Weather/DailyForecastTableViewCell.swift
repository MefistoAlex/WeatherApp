//
//  DailyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class DailyForecastTableViewCell: UITableViewCell {
    private let weatherViewModel = WeatherViewModel.shared
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func bindCollectionView() {
        // bind items to the table
        weatherViewModel.currentDayWeather.bind(
            to: collectionView.rx.items(
                cellIdentifier: String(describing: ForecastCollectionViewCell.self),
                cellType: ForecastCollectionViewCell.self)
        ) { _, item, cell in
            cell.setForecastWeather(item)
        }.disposed(by: disposeBag)

        // bind a model selected hendler

//        tableView.rx.modelSelected(DailyWeather.self).bind { dailyWeather in
//            self.weatherViewModel.currentDayWeather.onNext(dailyWeather.details[0])
//        }.disposed(by: disposeBag)

        // fetch items
//        weatherViewModel.fetchItem()
    }
}
