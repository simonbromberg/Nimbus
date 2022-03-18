//
//  ContentView.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-17.
//

import SwiftUI

struct WeatherView: View {
    @State var weather: Weather = .placeholder
    let dataProvider: DataProvider = NetworkProvider()

    let location: Location = .Toronto

    var body: some View {
        VStack {
            HStack {
                Text(weather.location)
                    .font(.title.weight(.bold))
                    .padding()
                Spacer()
            }
            CurrentWeather(
                iconName: weather.stateAbbreviation,
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

struct CurrentWeather: View {
    let iconName: String
    let temperature: Measurement<UnitTemperature>

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Spacer()
                Image(iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(temperature, format: temperatureFormat)")
                    .font(.system(size: geometry.size.height))
                Spacer()
            }
        }
    }
}

private let temperatureFormat = Measurement<UnitTemperature>.FormatStyle(
    width: .narrow,
    numberFormatStyle: .number
)

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: .test)
    }
}

extension Weather {
    static let placeholder: Self = .init(
        location: "Somewhere",
        temperature: .init(value: 0, unit: .celsius),
        low: .init(value: 0, unit: .celsius),
        high: .init(value: 0, unit: .celsius),
        stateName: "Sunny",
        stateAbbreviation: "s"
    )

    static let test: Self = .init(
        location: "Toronto",
        temperature: .init(value: 16, unit: .celsius),
        low: .init(value: 11, unit: .celsius),
        high: .init(value: 17, unit: .celsius),
        stateName: "Light Cloud",
        stateAbbreviation: "lc"
    )
}
