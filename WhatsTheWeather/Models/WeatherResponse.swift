//
//  Weather.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 13.04.2023.
//

import Foundation


struct WeatherResponse: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [DailyWeather]?
}


struct City: Codable {
    let id: Int?
    let name: String?
    let coord: CityCoordinates?
    let country: String?
}

struct CityCoordinates: Codable {
    let lon: Double?
    let lat: Double?
}

