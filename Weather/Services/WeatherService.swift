//
//  WeatherService.swift
//  Weather
//
//  Created by Tony Ayoub on 20-02-2023.
//

import CoreLocation

protocol WeatherService {
    func loadWeather(location: CLLocation, simulated: Bool) async throws -> Double?
}
