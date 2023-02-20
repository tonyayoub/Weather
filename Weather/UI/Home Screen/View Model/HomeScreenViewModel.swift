//
//  HomeScreenViewModel.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-18.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation

@MainActor
class HomeScreenViewModel: ObservableObject {
    // Subscriptions
    private var bag = Set<AnyCancellable>()
    
    // Published properties
    @Published var temperatureText = ""
    @Published var isLoading = true
    @Published var simulated = false
    
    // Injected properties
    private let locator: Locator
    private let service: WeatherService

    // Local data
    private var lastKnownTemperature: Double?
    private var lastKnownLocation: CLLocation?
    
    // UI events
    var scale: CurrentValueSubject<TemperatureScale, Never> = CurrentValueSubject(TemperatureScale.celsius)
    
    init(locator: Locator, service: WeatherService) {
        self.locator = locator
        self.service = service
        createSubscriptions()
    }

    private func createSubscriptions() {
        locator.publishLocation().sink { [weak self] location in
            self?.lastKnownLocation = location
            Task {
                self?.isLoading = true
                await self?.fetchWeather(location: location)
                self?.isLoading = false
            }
        }.store(in: &bag)
        
        scale.sink {
            self.temperatureText = String(self.getFormattedTemperature(
                value: self.lastKnownTemperature,
                scale: $0))
        }.store(in: &bag)
    }

    func fetchWeather(location: CLLocation) async {
        guard let fetchedTemperature = try? await service.loadWeather(
            location: location,
            simulated: simulated
        ) else {
            print("Error fetching weather. Try using simulated data.")
            return
        }
        lastKnownTemperature = fetchedTemperature
        temperatureText = String(self.getFormattedTemperature(value: lastKnownTemperature, scale: scale.value))
        isLoading = false
    }
    
    func reload() async {
        if let location = self.lastKnownLocation {
            await fetchWeather(location: location)
        }
    }

    func getFormattedTemperature(value: Double?, scale: TemperatureScale) -> String {
        guard let value else { return "" }
        let mf = MeasurementFormatter()
        let temp = Measurement(value: value, unit: UnitTemperature.celsius)
        mf.locale = getLocale(scale: scale)
        mf.numberFormatter.maximumFractionDigits = 0
        return mf.string(from: temp )
    }
    
    // A work around to change scale (Celsius/Fahrenheit) without manual calculations and formatting
    func getLocale(scale: TemperatureScale) -> Locale {
        scale == .celsius ? Locale(identifier: "en_GB") : Locale(identifier: "en_US")
    }
}

