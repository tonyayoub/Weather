//
//  WeatherApp.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-16.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: .init(locator: GPSLocator(),
                                        service: TomorrowWeatherService()
                                       ))
        }
    }
}
