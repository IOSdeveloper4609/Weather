//
//  Extention + Date.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import Foundation


extension Date {
    func getDateComponent(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

     func convertDate(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
        
