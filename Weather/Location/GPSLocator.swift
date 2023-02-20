//
//  GPSLocator.swift
//  Weather
//
//  Created by Tony Ayoub on 20-02-2023.
//

import CoreLocation
import Combine

struct GPSLocator: Locator {
    func publishLocation() -> AnyPublisher<CLLocation, Never> {
        CLLocationManager.publishLocation()
    }
}
