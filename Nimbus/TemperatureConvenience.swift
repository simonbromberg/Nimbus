//
//  TemperatureConvenience.swift
//  Nimbus
//
//  Created by Simon Bromberg on 2022-03-18.
//

import Foundation

typealias Temperature = Measurement<UnitTemperature>

extension Temperature: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Double(value))
    }

    init(_ value: Double) {
        self.init(value: value, unit: .celsius)
    }
}
