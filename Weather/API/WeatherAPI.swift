//
//  WeatherAPI.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/22.
//

import Foundation

extension ViewController {
    
    func localAPI(completion: @escaping ([Local]) -> Void) {
        let query = "https://www.metaweather.com/api/location/search/?query=se"
        guard let queryURL = URL(string: query) else { return }
        let requestURL = URLRequest(url: queryURL)
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            guard error == nil else { return print("error") }
            guard let data = data else { return print("data없음") }
            
            do {
                let data = try JSONDecoder().decode([Local].self, from: data)
                completion(data)
            } catch {
                print("DEBUG: Search Local", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func localWeather(location: Int, completion: @escaping (Weather) -> Void) {
        let query = "https://www.metaweather.com/api/location/\(location)/"
        guard let queryURL = URL(string: query) else { return }
        let requestURL = URLRequest(url: queryURL)
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            guard error == nil else { return print("Error") }
            guard let data = data else { return print("data 없음") }
            
            do {
                let data = try JSONDecoder().decode(Weather.self, from: data)
                completion(data)
            } catch {
                print("DEBUG: Search Products Request Error, ", error.localizedDescription)
            }
        }
        task.resume()
    }
}


