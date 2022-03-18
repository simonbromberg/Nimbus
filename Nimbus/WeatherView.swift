//
//  ContentView.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-17.
//

import SwiftUI

struct WeatherView: View {
    @Binding var weather: Weather

    var body: some View {
        VStack {
            HStack {
                Text(weather.location)
                    .font(.title.weight(.bold))
                    .padding()
                Spacer()
            }
            CurrentWeatherView(
                iconName: weather.state?.rawValue,
                temperature: weather.temperature
            )
            .frame(maxHeight: 100)
            Text(weather.stateName)
                .padding(.top, 10)
            Text("L: \(weather.low, format: temperatureFormat) H: \(weather.high, format: temperatureFormat)")
                .padding(.top, 2)
            Spacer()
        }
    }
}

struct CurrentWeatherView: View {
    let iconName: String?
    let temperature: Temperature

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Spacer()
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(temperature, format: temperatureFormat)")
                    .font(.system(size: geometry.size.height))
                Spacer()
            }
        }
    }

    var image: Image {
        iconName.map {
            Image($0)
        } ?? Image(systemName: "questionmark.diamond")
    }
}

private let temperatureFormat = Temperature.FormatStyle(
    width: .narrow,
    numberFormatStyle: .number
)

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: .constant(.test))
        WeatherView(weather: .constant(.test))
            .preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier: "en_CA"))
    }
}
