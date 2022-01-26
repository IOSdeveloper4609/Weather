//
//  NetworkManager.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import Foundation
import CoreLocation

class NetworkManager: Service {
    
    // MARK: - Get Weather
    
    func getWeather(city: String, completion: @escaping (WeatherData<WeatherForDay>?) -> Void) {
     let parameters = ["cnt": "5", "q": city]
        
        sendGetRequest(path: "/data/2.5/forecast/daily", host: "api.openweathermap.org", parameters: parameters, completion: completion)
    }
    
    // MARK: - Get Detaile Weather
    
    func getDetailWeather(city: String, completion: @escaping (WeatherData<DetailWeatherForDay>?) -> Void) {
     let parameters = ["q": city]
        
        sendGetRequest(path: "/data/2.5/forecast", host: "api.openweathermap.org", parameters: parameters, completion: completion)
    }
    
    // MARK: - Get Location By Coordinate
    
    func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees,completion: @escaping (WeatherData<WeatherForDay>?) -> Void) {
        let parameters = ["lat": String(latitude) ,"lon": String(longitude), "cnt": "5"]

        sendGetRequest(path: "/data/2.5/forecast/daily", host: "api.openweathermap.org" , parameters: parameters, completion: completion)
    }
    
    // MARK: - Get Location By Ip Adress
    
     func getlocationByIpAdress(completion: @escaping (LocationByIpAddressModel?) -> Void) {
        sendGetRequest(path: "/json", host: "ip-api.com", parameters: [:], completion: completion)
    }
}

