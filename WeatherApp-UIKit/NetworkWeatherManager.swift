//
//  NetworkService.swift
//  WeatherApp-UIKit
//
//  Created by SIMONOV on 09.08.2022.
//

import Foundation
import Alamofire

final class NetworkWeatherManager {
    
    func updateWeatherInfo(latitude: Double, longtitude: Double, completion: @escaping (WeatherData) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&units=metric&lang=ru&appid=be5a408cbd24596b8e3d293c7de6a60b", method: .get).response { data in
            switch data.result {
            case .success(let data):
                if let data = data {
                    if let result = try? JSONDecoder().decode(WeatherData.self, from: data) {
                        print(result)
                        completion(result)
                    }
                }
        
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
