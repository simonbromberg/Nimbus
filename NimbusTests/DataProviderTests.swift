//
//  DataProviderTests.swift
//  NimbusTests
//
//  Created by Simon Bromberg on 2022-03-17.
//

@testable import Nimbus
import XCTest

class DataProviderTests: XCTestCase {
    func testDecoding() async throws {
        let weather = try await MockProvider(filename: "weather").getWeather(location: .Toronto)
        XCTAssertEqual(
            weather,
            Weather(
                location: "Toronto",
                temperature: 6.9,
                low: 1.44,
                high: 7.56,
                stateName: "Heavy Cloud",
                stateAbbreviation: "hc"
            )
        )
    }

    func testEmptyWeather() async throws {
        var thrownError: Error?
        await XCTAssertThrowsError(
            try await MockProvider(filename: "weather_empty")
                .getWeather(location: .Toronto)
        ) {
            thrownError = $0
        }

        XCTAssertEqual(thrownError as? DataError, DataError.empty)
    }

    func testEmptyResponse() async throws {
        var thrownError: Error?
        await XCTAssertThrowsError(
            try await MockProvider(filename: "empty")
                .getWeather(location: .Toronto)
        ) {
            thrownError = $0
        }

        guard let error = thrownError else {
            XCTFail("Missing error")
            return
        }

        XCTAssertTrue(error is Swift.DecodingError)
    }

    func testMalformed() async throws {
        var thrownError: Error?
        await XCTAssertThrowsError(
            try await MockProvider(filename: "malformed")
                .getWeather(location: .Toronto)
        ) {
            thrownError = $0
        }

        guard let error = thrownError else {
            XCTFail("Missing error")
            return
        }

        XCTAssertTrue(error is Swift.DecodingError)
    }
}

// Copied from https://www.wwt.com/article/unit-testing-on-ios-with-async-await
extension XCTest {
    func XCTAssertThrowsError<T: Sendable>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}

extension Weather: @unchecked Sendable {}
