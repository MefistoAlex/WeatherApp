//
//  WeatherHeader.swift
//  WeatherApp
//
//  Created by Alexandr Mefisto on 21.09.2022.
//

import UIKit

class WeatherHeader: UIView {
    // MARK: Outlets
      
    @IBOutlet var contentView: WeatherHeader!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var windDirectionImage: UIImageView!

    // MARK: init

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("WeatherHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
