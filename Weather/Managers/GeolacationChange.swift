//
//  GeolacationChange.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//


import UIKit
import CoreLocation

protocol ManagerEventListener: AnyObject {
    func updateLocation(coordinate: CLLocationCoordinate2D)
}


final class GeolacationChange: NSObject {
    static let shared = GeolacationChange()
    
    private var managerEventListenerArray = [ManagerEventListener]()
    
    private var authorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    
    var locationServicesisEnabled: Bool {
        switch authorizationStatus {
        case .restricted, .notDetermined, .denied:
            return false
        case .authorizedWhenInUse,.authorizedAlways:
            return true
        default:
            return false
        }
    }
    
    private func didUpdateLocation(locations: CLLocationCoordinate2D) {
        managerEventListenerArray.forEach({ item in item.updateLocation(coordinate: locations)})
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
   private lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        
        return lm
    }()
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func add(listener: ManagerEventListener) {
        if !managerEventListenerArray.contains(where: { $0 === listener }) {
            managerEventListenerArray.append(listener)
        }
    }
    
    func remove(listener: ManagerEventListener) {
        if managerEventListenerArray.contains(where: { $0 === listener }) {
            managerEventListenerArray.removeAll()
        }
    }
    
    private override init() {
        
    }
}

extension GeolacationChange: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {
            return
        }
        didUpdateLocation(locations: coordinate)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_: CLLocationManager) {
        if locationServicesisEnabled {
            locationManager.requestLocation()
        }
    }
}


