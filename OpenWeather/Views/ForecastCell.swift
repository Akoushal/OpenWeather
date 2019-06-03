//
//  ForecastCell.swift
//  WeatherForecast
//
//  Created by Koushal, KumarAjitesh on 2019/05/10.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
//    @IBOutlet weak var placeNameLbl: UILabel?
//    @IBOutlet weak var dateLbl: UILabel?
//    @IBOutlet weak var maxTempLbl: UILabel?
//    @IBOutlet weak var minTempLbl: UILabel?
//    @IBOutlet weak var dayWeatherConditionLbl: UILabel?
//    @IBOutlet weak var nightWeatherConditionLbl: UILabel?
//    @IBOutlet weak var dayImgView: UIImageView?
//    @IBOutlet weak var nightImgView: UIImageView?
//    private let utils = Utilities()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func configure(listObj: DailyForecast?, loc: LocationList?, vm: WeatherViewModel, index: Int) {
//        dayImgView?.image = UIImage(named: "dayIcon")
//        nightImgView?.image = UIImage(named: "nightIcon")
//
//        guard let obj = listObj, let date = obj.date, let temp = obj.temperature, let maxTemp = temp.maximum?.value, let minTemp = temp.minimum?.value, let dayCondition = obj.day?.iconPhrase, let nightCondition = obj.night?.iconPhrase, let location = loc else { return}
//        placeNameLbl?.text = location.localizedName
//        dateLbl?.text = getDate(for: date)
//        maxTempLbl?.text = utils.convertFahrenheitToDegreeCelsius(temp: maxTemp)
//        minTempLbl?.text = utils.convertFahrenheitToDegreeCelsius(temp: minTemp)
//        dayWeatherConditionLbl?.text = dayCondition + " during day"
//        nightWeatherConditionLbl?.text = nightCondition + " during night"
//    }
//
//    func getDate(for str: String) -> String {
//        let date: Date = utils.convertStringToDate(str: str)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
//        return dateFormatter.string(from: date)
//    }
}
