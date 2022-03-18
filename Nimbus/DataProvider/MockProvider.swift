//
//  MockProvider.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-18.
//

import Foundation

struct MockProvider: DataProvider {
    let filename: String

    init(filename: String) {
        self.filename = filename
    }

    func getWeather(location _: Location) async throws -> Weather {
        guard let url = Bundle.main.url(
            forResource: "fixtures/\(filename)",
            withExtension: "json"
        )
        else {
            throw DataError.empty
        }

        let data = try Data(contentsOf: url)
        return try decode(data)
    }
}
