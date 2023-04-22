//
//  DailyWeather.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 15.04.2023.
//

import Foundation


struct DailyWeather: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?
}



extension DailyWeather {
    var id: UUID {
        return UUID()
    }
}

struct Sys: Codable {
    let pod: String?
}

struct Clouds: Codable {
    let all: Int?
}

struct Rain: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

       enum CodingKeys: String, CodingKey {
           case temp
           case feelsLike = "feels_like"
           case tempMin = "temp_min"
           case tempMax = "temp_max"
           case pressure
           case seaLevel = "sea_level"
           case grndLevel = "grnd_level"
           case humidity
           case tempKf = "temp_kf"
       }
}
