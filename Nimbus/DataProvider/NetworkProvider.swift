//
//  NetworkProvider.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-17.
//

import Foundation

struct NetworkProvider: DataProvider {
    func getWeather(location: Location) async throws -> Weather {
        let (data, _) = try await URLSession.shared.data(from: baseURL(location: location))
        return try decode(data)
    }

    private func baseURL(location: Location) -> URL {
        URL(string: "https://www.metaweather.com/api/location/\(location.id)/")!
    }
}
