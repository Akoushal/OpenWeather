//
//  WeatherHelperService.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/02.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation
import PromiseKit

public class WeatherHelperService {
    var totalWeatherData: [WeatherData] = [WeatherData]()
    let dispatchGroup = DispatchGroup()
    
    func getWeatherForAllCities(viewModel: WeatherViewModel) {
        viewModel.weatherData = []
        viewModel.cities.forEach { (city) in
            performOperationForCity(cityName: city)
        }
        
        dispatchGroup.notify(queue: .main) {
            viewModel.weatherData = self.totalWeatherData
        }
    }
    
    func performOperationForCity(cityName: String) {

        dispatchGroup.enter()
        var tempWeather: WeatherData = WeatherData()
        getWeather(for: cityName).then { [weak self] weatherInfo -> Promise<UIImage> in
            guard let self = self else { return brokenPromise() }
            tempWeather.weatherInfo = weatherInfo
            
            return (self.getIcon(named: weatherInfo.weather.first!.icon))
            }
            .done(on: DispatchQueue.main) { icon in
                tempWeather.iconImage = icon
                self.totalWeatherData.append(tempWeather)
                self.dispatchGroup.leave()
            }
            .catch { error in
                print(error)
        }
    }
    
    func getWeather(for city: String) -> Promise<WeatherInfo> {
        let urlString = "\(Configuration.CityWeatherBaseURL)\(city)&appid=\(Configuration.APIKey)"
        let url = URL(string: urlString)!
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                return try JSONDecoder().decode(WeatherInfo.self, from: $0.data)
        }
    }
    
    func getIcon(named iconName: String) -> Promise<UIImage> {
        return Promise<UIImage> {
            getFile(named: iconName, completion: $0.resolve)
            }
            .recover { _ in
                self.getIconFromNetwork(named: iconName)
        }
    }
    
    func getIconFromNetwork(named iconName: String) -> Promise<UIImage> {
        let urlString = "http://openweathermap.org/img/w/\(iconName).png"
        let url = URL(string: urlString)!
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }
            .then(on: DispatchQueue.global(qos: .background)) { urlResponse in
                return Promise {
                    self.saveFile(named: iconName, data: urlResponse.data, completion: $0.resolve)
                    }
                    .then(on: DispatchQueue.global(qos: .background)) {
                        return Promise.value(UIImage(data: urlResponse.data)!)
                }
        }
    }
    
    
    private func saveFile(named: String, data: Data, completion: @escaping (Error?) -> Void) {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(named+".png") else { return }
        
        DispatchQueue.global(qos: .background).async {
            do {
                try data.write(to: path)
                print("Saved image to: " + path.absoluteString)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    private func getFile(named: String, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(named+".png"),
                let data = try? Data(contentsOf: path),
                let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image, nil) }
            } else {
                let error = NSError(domain: "WeatherOrNot",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Image file '\(named)' not found."])
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
    }
}
