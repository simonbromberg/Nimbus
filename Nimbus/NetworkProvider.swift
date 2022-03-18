//
//  NetworkProvider.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-17.
//

import Foundation

private typealias ResponseData = WeatherResponse

protocol DataProvider {
    func getWeather(location: Location) async throws -> Weather
}

extension DataProvider {
    func decode(_ data: Data) throws -> Weather {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let jsonData = try decoder.decode(ResponseData.self, from: data)

        guard let weather = jsonData.consolidatedWeather.first else {
            throw NetworkError.malformed
        }

        return .init(
            location: jsonData.title,
            temperature: .init(value: weather.theTemp, unit: .celsius),
            low: .init(value: weather.minTemp, unit: .celsius),
            high: .init(value: weather.maxTemp, unit: .celsius),
            stateName: weather.weatherStateName,
            stateAbbreviation: weather.weatherStateAbbr
        )
    }
}

struct NetworkProvider: DataProvider {
    func getWeather(location: Location) async throws -> Weather {
        let (data, _) = try await URLSession.shared.data(from: baseURL(location: location))
        return try decode(data)
    }

    private func baseURL(location: Location) -> URL {
        URL(string: "https://www.metaweather.com/api/location/\(location.id)/")!
    }
}

enum NetworkError: Error {
    case malformed
    case error(Error)
}

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
