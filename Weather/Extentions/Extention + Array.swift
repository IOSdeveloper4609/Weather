//
//  Extention + Array.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import Foundation


extension Array {
   subscript (safe index: Int) -> Element? {
       return indices.contains(index) ? self[index] : nil
   }
}
