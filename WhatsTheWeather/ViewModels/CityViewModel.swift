//
//  CityViewModel.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 15.04.2023.
//

import SwiftUI
import CoreLocation

final class CityViewModel: ObservableObject {
    
    @Published var weather: WeatherResponse?
    @Published var city: String = "Unknown"
    @Published var country: String = "Unknown"
    var measurementTypes = ["F\u{00B0}", "C\u{00B0}"]
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
   
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
     var todaysDate: String {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMM d, yyyy"
        let todayDate = formatter.string(from: Date())
        return "Today, \(todayDate)"
    }
 
    var weatherIcon: String {
        if weather?.list?.count ?? 0 > 0 {
            return weather?.list?.first?.weather?.first?.iconImage ?? "sun.max.fill"
        }
        return "sun.max.fill"
    }
    
    var tempCelsius: String {
        let degreeSymbol = "\u{00B0}"
        let celcius = ((weather?.list?.first?.main?.temp ?? 0.0) - 32) * 5 / 9
        
        return "\(getTempFor(temp: celcius))\(degreeSymbol)"
    }

    var temperature: String {
        let degreeSymbol = "\u{00B0}"
        return "\(getTempFor(temp: weather?.list?.first?.main?.temp ?? 0.0))\(degreeSymbol)"
    }
    
    var airPressure: String {
        return "\(weather?.list?.first?.main?.pressure ?? 0)"
    }

    var windSpeed: String {
        return String(format: "%0.1f", weather?.list?.first?.wind?.speed ?? 0.0)
    }
   
    var humidity: String {
        return String(format: "%d%%", weather?.list?.first?.main?.humidity ?? 0)
    }
   
    var rainChances: String {
        return String(format: "%0.0f%%", weather?.list?.first?.wind?.gust ?? 0.0)
    }
   
    var visibility: String {
        let visibilityInMiles = Double((weather?.list?.first?.visibility ?? Int(0.0)))*0.00062137
        return String(format: "%0.1f", visibilityInMiles)
    }
    
    init() {
      
    }
    
    func getTimerFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        
        return String(format: "%0.f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getWeather(coord: CLLocationCoordinate2D) {
          let urlString = NetworkService.shared.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherFor(city: "", urlString: urlString)
    }
    
    private func getWeatherFor(city: String, urlString: String) {
        NetworkService.shared.performFetch(with: URL(string: urlString)!, successModel: WeatherResponse.self) { result in
            switch result {
            case .success(let t):
                self.weather = t
                print(self.weather?.list?.count ?? 0)
            case .unauthorized(let failureModel):
                print(failureModel)
            }
        }
    }
    
     func fetchCurrentLocationInfo(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: lon)) { placemarks, error in
            if let places = placemarks, let place = placemarks?.first {
                self.city = place.locality ?? "N/A"
                self.country = place.country ?? "N/A"
                print(self.city, self.country)
                
            }
        }
    }
    
    
}
