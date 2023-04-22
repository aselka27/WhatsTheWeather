//
//  TodayTemperature.swift
//  WhatsTheWeather
//
//  Created by саргашкаева on 6.04.2023.
//

import SwiftUI

struct TodayTemperature: View {
    var temperature: String
    var imageIcon: String
    var imageWidth: CGFloat = 60.0
    @State private var isRotating = 0.0
    
    init(icon: String, temperature: String) {
        self.imageIcon = icon
        self.temperature = temperature
    }
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 200, height: 200)
               
            VStack(spacing: 3) {
                Image(systemName: imageIcon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: imageWidth, height: imageWidth)
             
                Text(temperature)
                    .font(.system(size: 60, weight: .light))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.black)
                    .padding(.horizontal)
            }
           
        }
    }
}

struct TodayTemperature_Previews: PreviewProvider {
    static var previews: some View {
        TodayTemperature(icon: "sun.max.fill", temperature: "10")
    }
}
