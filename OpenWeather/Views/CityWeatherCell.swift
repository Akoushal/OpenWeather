//
//  CityWeatherCell.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/02.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    private let utils = Utilities()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(weatherData: WeatherData) {
        guard let name = weatherData.weatherInfo?.name, let temp = weatherData.weatherInfo?.main.temp, let image = weatherData.iconImage else { return}
        iconImage.image = image
        cityName.text = name
        temperatureLabel.text = utils.convertKelvinToDegreeCelsius(temp: temp)
    }
}
