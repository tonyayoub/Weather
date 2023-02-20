//
//  Locator.swift
//  Weather
//
//  Created by Tony Ayoub on 20-02-2023.
//

import CoreLocation
import Combine

protocol Locator {
    func publishLocation() -> AnyPublisher<CLLocation, Never>
}
