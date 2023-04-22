//
//  ContentView.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 6.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CityViewModel()
    @EnvironmentObject var locationManager: LocationManager
   @State private var temperatureMeasurement = "F\u{00B0}"
    private let dailyWeatherRow: [GridItem] = [GridItem(.adaptive(minimum: 50))]
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text(viewModel.todaysDate)
                        .font(.body)
                        .padding(.bottom)
                            .foregroundColor(.white)
                    Text(viewModel.city)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                    Text(viewModel.country)
                        .font(.custom("SF-Pro", size: 19))
                            .foregroundColor(.white)
                    Picker("measurement", selection: $temperatureMeasurement) {
                        ForEach(viewModel.measurementTypes, id: \.self) {
                            Text($0)
                                
                                .padding()
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    .frame(width: 70, height: 30)
                 
                    Spacer()
                    TodayTemperature(icon: viewModel.weatherIcon, temperature: temperatureMeasurement == "F\u{00B0}" ? viewModel.temperature : viewModel.tempCelsius)
                        .shadow(color: .white, radius: 12)
                    Spacer()
                         cityInfoView
                    Spacer()
                        }

                 Spacer()
                ZStack {
                    VStack(alignment: .center) {
                        Text("The next hours")
                           .bold()
                           .padding(.leading, 30)
                           .padding(.top)
                        
                        LazyHStack(alignment: .center) {
                                if let weatherList = viewModel.weather?.list {
                                    ForEach(weatherList, id: \.dt) { weather in
                                        DailyTemperature(dailyWeather: weather)
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(Color("lightGray"), lineWidth: 1)
                                            )
                                    }
                                }
                                  
                            }
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                        
                 }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.35)
                 .background(.white)
                 .cornerRadius(60, corners: [.topLeft, .topRight])
                 
            }
            .ignoresSafeArea()
        
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color("aquaBlue"), Color("darkBlue")], startPoint: .top, endPoint: .bottom))
        .onAppear {
            if let location = locationManager.locationCoordinates {
                viewModel.getWeather(coord: location)
                viewModel.fetchCurrentLocationInfo(lat: location.latitude, lon: location.longitude)
            }
            
        }
       
      
    }
        
    
        
}

extension ContentView {
    var cityInfoView: some View {
        HStack(spacing: 100) {
            VStack(alignment: .center) {
                Text("Wind status")
                    .foregroundColor(.white)
                Text("\(viewModel.windSpeed) mph")
                    .foregroundColor(.white)
                Text("Humidity")
                    .foregroundColor(.white)
                    .padding(.top, 6)
                Text(viewModel.humidity)
                    .foregroundColor(.white)
            }
            VStack(alignment: .center) {
                Text("Visibility")
                    .foregroundColor(.white)
                Text("\(viewModel.visibility) miles")
                    .foregroundColor(.white)
                Text("Air pressure")
                    .foregroundColor(.white)
                    .padding(.top, 6)
                Text("\(viewModel.airPressure) mb")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager())
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
