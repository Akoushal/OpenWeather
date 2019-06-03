//
//  WeatherDetailViewController.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/02.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet private weak var placeNameLbl: UILabel!
    @IBOutlet private weak var currentTimeLbl: UILabel!
    @IBOutlet private weak var weatherDescLbl: UILabel!
    @IBOutlet private weak var currentTempLbl: UILabel!
    @IBOutlet private weak var maxTempLbl: UILabel!
    @IBOutlet private weak var minTempLbl: UILabel!
    @IBOutlet private weak var windSpeedLbl: UILabel!
    @IBOutlet private weak var cloudinessLbl: UILabel!
    var weatherData: WeatherData = WeatherData()
    private let utils = Utilities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        guard let name = weatherData.weatherInfo?.name, let timeStamp = weatherData.weatherInfo?.dt, let desc = weatherData.weatherInfo?.weather[0].description, let currentTemp = weatherData.weatherInfo?.main.temp, let maxTemp = weatherData.weatherInfo?.main.temp_max, let minTemp = weatherData.weatherInfo?.main.temp_min, let windSpeed = weatherData.weatherInfo?.wind.speed, let cloudinessPercentage = weatherData.weatherInfo?.clouds.all else { return}
        placeNameLbl.text = name
        currentTimeLbl.text = utils.convertDateStampToDateString(dt: timeStamp)
        weatherDescLbl.text = desc.localizedCapitalized
        currentTempLbl.text = utils.convertKelvinToDegreeCelsius(temp: currentTemp)
        maxTempLbl.text = utils.convertKelvinToDegreeCelsius(temp: maxTemp)
        minTempLbl.text = utils.convertKelvinToDegreeCelsius(temp: minTemp)
        windSpeedLbl.text = String(format: "%.0f m/s", windSpeed) // Wind speed by default is in meters per second
        cloudinessLbl.text = String(format: "%.0f", cloudinessPercentage)
    }
}
