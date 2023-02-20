//
//  CLLocationManager+Publisher.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-18.
//

import Foundation
import Combine
import CoreLocation

extension CLLocationManager {
    public static func publishLocation() -> AnyPublisher<CLLocation, Never> { LocationPublisher().eraseToAnyPublisher() }

    public struct LocationPublisher: Publisher {
        public typealias Output = CLLocation
        public typealias Failure = Never

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = LocationSubscription(subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
        
        final class LocationSubscription<S: Subscriber> : NSObject, CLLocationManagerDelegate, Subscription where S.Input == Output, S.Failure == Failure{
            var subscriber: S
            var locationManager = CLLocationManager()
            
            init(subscriber: S) {
                self.subscriber = subscriber
                super.init()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                locationManager.distanceFilter = 3000
            }

            func request(_ demand: Subscribers.Demand) {
                locationManager.startUpdatingLocation()
                locationManager.requestWhenInUseAuthorization()
            }
            
            func cancel() {
                locationManager.stopUpdatingLocation()
            }
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location = locations.first {
                    _ = subscriber.receive(location)
                }
            }
        }
    }
}
