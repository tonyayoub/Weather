//
//  HomeScreenViewModelTests.swift
//  WeatherTests
//
//  Created by Tony Ayoub on 2023-02-16.
//

import XCTest
import CoreLocation
import Combine
@testable import Weather

final class HomeScreenViewModelTests: XCTestCase {
    var bag = Set<AnyCancellable>()
    let locator = MockLocator()
    let service = MockWeatherService()
    
    @MainActor func testLoadingWeather() async throws {
        let viewModel = HomeScreenViewModel(locator: locator, service: service)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertEqual(viewModel.scale, .celsius)
        await viewModel.fetchWeather(location: CLLocation())
        XCTAssertNotEqual(viewModel.temperatureText, "")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    @MainActor func testSwitchingScale() async throws {
        let viewModel = HomeScreenViewModel(locator: locator, service: service)
        await viewModel.fetchWeather(location: CLLocation())
        let celsiusTemperatureText = viewModel.temperatureText
        XCTAssertNotEqual(celsiusTemperatureText, "")
        viewModel.scale = .fahrenheit
        let scaleExpectation = XCTestExpectation(description: "Scale changed")
        viewModel.$scale
            .sink {
                if $0 == .fahrenheit {
                    let fahrenheitTemperatureText = viewModel.temperatureText
                    XCTAssertNotEqual(celsiusTemperatureText, fahrenheitTemperatureText)
                    scaleExpectation.fulfill()
                }
            }
            .store(in: &bag)

        wait(for: [scaleExpectation], timeout: 1)
    }
}
