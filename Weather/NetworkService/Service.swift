//
//  Service.swift
//  Weather
//
//  Created by Азат Киракосян on 24.09.2021.
//

import Foundation


class Service {
   private let baseParameters = ["units": "metric","lang":"ru", "apikey": apiKey]
    
    func baseGetRequest<T: Decodable>(url: URLComponents, completion: @escaping (T?) -> Void) {
        guard let url = url.url else {
            completion(nil)
            assertionFailure("missing url request")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,_,error in
            if let error = error {
                completion(nil)
                assertionFailure(error.localizedDescription)
                return
            }
            if let data = data {
                guard let results = self.parceResponse(T.self, data: data) else {
                    return
                }
                completion(results)
            }
        }.resume()
    }
    
    func sendGetRequest<T: Decodable>(path: String,host: String, parameters: [String:String], completion: @escaping (T?) -> Void) {
        var param = baseParameters
        parameters.forEach({ param[$0] = $1 })
        let result = param.compactMap { URLQueryItem(name: $0, value: $1) }
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = result
        
        baseGetRequest(url: urlComponents, completion: completion)
    }

  private func parceResponse<T>(_ type: T.Type,data: Data) -> T? where T: Decodable {
        do {
            let weather = try JSONDecoder().decode(T.self, from: data)
            return weather
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

   
    
    
    
    
    
    
    
   
    

