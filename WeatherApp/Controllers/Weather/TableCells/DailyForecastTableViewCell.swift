//
//  DailyForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 27.09.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class DailyForecastTableViewCell: UITableViewCell {
    private let weatherViewModel = WeatherViewModel.shared
    private let disposeBag = DisposeBag()

    @IBOutlet private var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bindCollectionView()
    }

    private func bindCollectionView() {
        weatherViewModel.currentDayWeather.bind(
            to: collectionView.rx.items(
                cellIdentifier: String(describing: ForecastCollectionViewCell.self),
                cellType: ForecastCollectionViewCell.self)
        ) { _, item, cell in
            cell.setForecastWeather(item)
        }.disposed(by: disposeBag)

        weatherViewModel.fetchItem()
    }
}
