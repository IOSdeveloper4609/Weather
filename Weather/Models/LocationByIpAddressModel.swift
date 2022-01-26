//
//  LocationByIpAddressModel.swift
//  Weather
//
//  Created by usermac on 24.09.2021.
//

import Foundation
import CoreLocation


struct LocationByIpAddressModel: Codable {
    let latitude: Double
    let longitude: Double
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case city
    }
    var locationCoordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
