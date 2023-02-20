//
//  MockWeatherService.swift
//  WeatherTests
//
//  Created by Tony Ayoub on 20-02-2023.
//

import CoreLocation
@testable import Weather

struct MockWeatherService: WeatherService {
    func loadWeather(location: CLLocation, simulated: Bool) async throws -> Double? {
        Double.random(in: -30...30)
    }
}
