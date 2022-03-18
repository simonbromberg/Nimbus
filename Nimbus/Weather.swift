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
    let state: State?
    let stateName: String

    enum State: String {
        case clear = "c"
        case hail = "h"
        case heavyCloud = "hc"
        case heavyRain = "hr"
        case lightCloud = "lc"
        case lightRain = "lr"
        case showers = "s"
        case sleet = "sl"
        case snow = "sn"
        case thunderstorm = "t"
    }
}

extension Weather {
    static let placeholder: Self = .init(
        location: "--",
        temperature: 0,
        low: 0,
        high: 0,
        state: .clear,
        stateName: "--"
    )

    static let test: Self = .init(
        location: "Toronto",
        temperature: 16,
        low: 11,
        high: 17,
        state: .lightCloud,
        stateName: "Light Cloud"
    )
}
