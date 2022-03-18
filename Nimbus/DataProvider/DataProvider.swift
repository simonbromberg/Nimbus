//
//  DataProvider.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-18.
//

import Foundation

protocol DataProvider {
    func getWeather(location: Location) async throws -> Weather
}

extension DataProvider {
    func decode(_ data: Data) throws -> Weather {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let jsonData = try decoder.decode(WeatherResponse.self, from: data)

        guard let weather = jsonData.consolidatedWeather.first else {
            throw DataError.empty
        }

        return .init(
            location: jsonData.title,
            temperature: Temperature(weather.theTemp),
            low: Temperature(weather.minTemp),
            high: Temperature(weather.maxTemp),
            state: .init(rawValue: weather.weatherStateAbbr),
            stateName: weather.weatherStateName
        )
    }
}

// MARK: - Response Data

struct WeatherResponse: Decodable {
    let consolidatedWeather: [WeatherSnapshot]
    let title: String
}

struct WeatherSnapshot: Decodable {
    let weatherStateName: String
    let weatherStateAbbr: String
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
}

// MARK: - Error

enum DataError: LocalizedError {
    case empty

    var errorDescription: String? {
        switch self {
        case .empty:
            return "There is no weather at this location!"
        }
    }
}
