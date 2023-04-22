//
//  DailyTemperature.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 6.04.2023.
//

import SwiftUI

struct DailyTemperature: View {
    
  @State var temperature = "10 C"
    var dailyWeather: DailyWeather
  
    
    init(dailyWeather: DailyWeather) {
      
        self.dailyWeather = dailyWeather
    }
    var body: some View {
        
        VStack {
            VStack {
                Image(systemName: dailyWeather.weather?.first?.iconImage ?? "")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
               let temp = String(format: "%0.f", dailyWeather.main?.temp ?? 0.0)
                Text(temp)
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 12)
        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 25)
//                .stroke(Color("lightGray"), lineWidth: 1)
//        )
    }
}

//struct DailyTemperature_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyTemperature(containerWidth: 36, dailyWeather: Da)
//            .previewLayout(.sizeThatFits)
//    }
//}
