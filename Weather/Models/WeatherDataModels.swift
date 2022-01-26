//
//  WeatherDataModels.swift
//  Weather
//
//  Created by usermac on 24.09.2021.
//

import Foundation


// MARK: - WeatherData

struct WeatherData<T>: Codable where T: Codable {
    let weather: [T]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case weather = "list"
        case city
    }
}

struct City: Codable {
    let name: String
    let coord: Coord
}

struct Coord: Codable {
    let lat, lon: Double
}

struct WeatherForDay: Codable {
    let date: Double
    let pressure: Int
    let feelsLike: FeelsLike
    let temperature: Temperature
    let rain: Double?
    let speed: Double
    let description: [Description]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case rain
        case pressure
        case temperature = "temp"
        case description = "weather"
        case feelsLike = "feels_like"
        case speed
    }
}

struct Description: Codable {
    let description: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case id
    }
}

struct Temperature: Codable {
    let temperatureDay: Double
    let temperatureNight: Double
    
    enum CodingKeys: String, CodingKey {
        case temperatureDay = "day"
        case temperatureNight = "night"
    }
}

struct FeelsLike: Codable {
    let day: Double?
}

// MARK: - DetailWeatherData

struct DetailWeatherForDay: Codable {
    let date: Double
    let temperature: DetailTemperature
    let description: [Description]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "main"
        case description = "weather"
    }
}

struct DetailTemperature: Codable {
    let temperature: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}






