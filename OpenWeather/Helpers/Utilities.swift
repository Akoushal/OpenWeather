//
//  Utilities.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/01.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import Foundation

class Utilities {
    //Convert Temperature to Degree Celsius
    func convertKelvinToDegreeCelsius(temp: Double) -> String {
        let temperatureInCelsius = temp - 273.15
        return String(format: "%.0f °C", temperatureInCelsius)
    }
    
    func convertFahrenheitToDegreeCelsius(temp: Double) -> String {
        let temperatureInCelsius = (temp - 32) / 1.8
        return String(format: "%.0f °C", temperatureInCelsius)
    }
    
    //Convert TimeStamp to DateString
    func convertDateStampToDateString(dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current //Set timezone that you want
        dateFormatter.locale = Locale.current
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func convertStringToDate(str: String) -> Date {
        let isoDate = str
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        return dateFormatter.date(from: isoDate)!
    }
}
