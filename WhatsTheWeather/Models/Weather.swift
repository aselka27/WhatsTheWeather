//
//  Weather.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 15.04.2023.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

extension Weather {
    var iconImage: String {
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d":
            return "cloud.fill"
        case "03n":
            return "cloud.fill"
        case "04d":
            return "cloud.fill"
        case "04n":
            return "cloud.fill"
        case "09d":
            return "cloud.drizzle.fill"
        case "09n":
            return "cloud.drizzle.fill"
        case "10d":
            return "cloud.heavyrain.fill"
        case "10n":
            return "cloud.heavyrain.fill"
        case "11d":
            return "cloud.bolt.fill"
        case "11n":
            return "cloud.bolt.fill"
        case "13d":
            return "cloud.snow.fill"
        case "13n":
            return "cloud.snow.fill"
        case "50d":
            return "cloud.fog.fill"
        case "50n":
            return "cloud.fog.fill"
        default:
            return "sun.max.fill"
        }
    }
}
