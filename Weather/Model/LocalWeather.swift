//
//  LocalWeather.swift
//  Weather
//
//  Created by ㅇ오ㅇ on 2020/12/22.
//

import UIKit

struct Local: Decodable {
    var woeid: Int
}

struct Weather: Decodable {
    var title: String
    var consolidated_weather: [consolidated_weather]
}

struct consolidated_weather: Decodable {
    var weather_state_name: String
    var weather_state_abbr: String
    var the_temp: Double
    var humidity: Int
}
