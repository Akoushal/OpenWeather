//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/01.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation
import PromiseKit

class WeatherViewModel {
    
    var weatherData: [WeatherData]? {
        didSet {
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var cities: [String] = ["Dubai", "London", "Tokyo"]
    
    private var weatherApi: WeatherHelperService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var tempWeather: WeatherData = WeatherData()
    
    // MARK: - Constructor
    init(weatherApi: WeatherHelperService) {
        self.weatherApi = weatherApi
    }
    
    // MARK: - Network call
    func fetchWeather(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if cities.count > 0 {
            if let currentLocation: String = UserDefaults.standard.value(forKey: Titles.currentLocation) as? String {
                cities[0] = currentLocation
            }
            weatherApi?.getWeatherForAllCities(viewModel: self)
        }
    }
}
