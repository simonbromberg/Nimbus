//
//  File.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-17.
//

import Foundation

struct Weather: Equatable {
    let location: String
    let temperature: Temperature
    let low: Temperature
    let high: Temperature

    let stateName: String
    let stateAbbreviation: String
}

extension Weather {
    static let placeholder: Self = .init(
        location: "--",
        temperature: 0,
        low: 0,
        high: 0,
        stateName: "--",
        stateAbbreviation: "c"
    )

    static let test: Self = .init(
        location: "Toronto",
        temperature: 16,
        low: 11,
        high: 17,
        stateName: "Light Cloud",
        stateAbbreviation: "lc"
    )
}
