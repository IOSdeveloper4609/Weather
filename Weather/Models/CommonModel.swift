//
//  CommonModel.swift
//  Weather
//
//  Created by usermac on 24.09.2021.
//

import Foundation
import UIKit


class CommonModel  {
    let description: String
    let temperatureDay: Double
    let date: Date
    let conditionCode: Int
    var weatherStateImage: UIImage? {
        switch conditionCode {
        case 200...232: return UIImage(systemName: "cloud.bolt.rain.fill")
        case 300...321: return UIImage(systemName: "cloud.drizzle.fill")
        case 500...531: return UIImage(systemName: "cloud.rain.fill")
        case 600...622: return UIImage(systemName: "cloud.snow.fill")
        case 701...781: return UIImage(systemName: "smoke.fill")
        case 800: return UIImage(systemName: "sun.min.fill")
        case 801...804: return UIImage(systemName: "cloud.fill")
        default: return UIImage(systemName: "nosign")
        }
    }
    init (description: String?,temperatureDay: Double,date: Double,conditionCode: Int?) {
        self.description = description ?? ""
        self.temperatureDay = temperatureDay
        self.date = Date(timeIntervalSince1970: date)
        self.conditionCode = conditionCode ?? 0
    }
}




