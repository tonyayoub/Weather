//
//  MockLocator.swift
//  WeatherTests
//
//  Created by Tony Ayoub on 20-02-2023.
//

import CoreLocation
import Combine
@testable import Weather

struct MockLocator: Locator {
    func publishLocation() -> AnyPublisher<CLLocation, Never> {
        Just(CLLocation()).eraseToAnyPublisher()
    }
}
