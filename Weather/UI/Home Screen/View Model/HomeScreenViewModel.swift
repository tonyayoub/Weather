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
    private var bag = Set<AnyCancellable>()
    private let service = WeatherService()
    private var locator = CLLocationManager.publishLocation().debounce(for: 3, scheduler: RunLoop.main)
    private var temperature = CurrentValueSubject<Double?, Never>(nil)
    var scale: CurrentValueSubject<TemperatureScale, Never> = CurrentValueSubject(TemperatureScale.celsius)
    
    @Published var temperatureText = ""
    @Published var image = ""
    @Published var hint = ""
    
    init() {
//        Publishers.CombineLatest(locator, scale).sink {
//            print($0)
//            print($1)
//        }
//        .store(in: &bag)
        locator.sink { [self] location in
            print(location)
            Task {
                temperature.value = try await self.service.loadWeather(location: location)
                let formatted = String(self.getFormattedTemperature(value: temperature.value, scale: scale.value))
                self.temperatureText = formatted
            }
        }
        .store(in: &bag)
        
        scale.sink {
            let formatted = String(self.getFormattedTemperature(value: self.temperature.value, scale: $0))
            self.temperatureText = formatted
        }
        .store(in: &bag)
    }

    func getFormattedTemperature(value: Double?, scale: TemperatureScale) -> String {
        guard let value else { return "" }
        let mf = MeasurementFormatter()
        let temp = Measurement(value: value, unit: UnitTemperature.celsius)
//        mf.locale = Locale(identifier: "en_GB")
        mf.locale = getUsedLocale(scale: scale)
        mf.numberFormatter.maximumFractionDigits = 1
        
        return mf.string(from: temp )
    }
    
    func getUsedLocale(scale: TemperatureScale) -> Locale {
        scale == .celsius ? Locale(identifier: "en_GB") : Locale(identifier: "en_US")
    }
}

