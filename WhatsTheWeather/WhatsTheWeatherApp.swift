//
//  WhatsTheWeatherApp.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 6.04.2023.
//

import SwiftUI

@main
struct WhatsTheWeatherApp: App {
   var locationManager: LocationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .onAppear {
                    locationManager.requestLocation()
                }
        }
    }
}
