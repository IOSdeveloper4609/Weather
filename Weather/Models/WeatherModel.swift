//
//  WeatherModel.swift
//  Weather
//
//  Created by usermac on 24.09.2021.
//

import Foundation


final class WeatherModel: CommonModel {
    var rain: Double
    var wind: Double
    var feelsLike: Double
    var temperatureNight: Double
    var pressure: Int
    
    init(weatherForDay: WeatherForDay) {
        rain = weatherForDay.rain ?? 0.0
        temperatureNight =  weatherForDay.temperature.temperatureNight
        wind = weatherForDay.speed
        pressure = weatherForDay.pressure
        feelsLike = weatherForDay.feelsLike.day ?? 0.0
        
        super.init(description: weatherForDay.description.first?.description,
                   temperatureDay: weatherForDay.temperature.temperatureDay,
                   date: weatherForDay.date,
                   conditionCode: weatherForDay.description.first?.id )
    }
}

