//
//  TomorrowWeatherService.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-18.
//

import Foundation
import CoreLocation

struct TomorrowWeatherService: WeatherService {
    let apiKey = "3kAMML3a9G33tK3gTVQ0BDFlZZyRGq79"
    
    func loadWeather(location: CLLocation, simulated: Bool = false) async throws -> Double? {
        if simulated {
            return Double.random(in: -30...30)
        }
        let dateFormatter = ISO8601DateFormatter()
        let startDate = dateFormatter.string(from: Date())
        let endDate = dateFormatter.string(from: Date().addingTimeInterval(60 * 60))
                                             
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(startDate)&endTime=\(endDate)&apikey=\(apiKey)") else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let weather = try? JSONDecoder().decode(Weather.self, from: data)
            if let value = weather?.data.timelines[0].intervals[0].values.temperature {
                print("Weather service responded successfully")
                return value
            } else {
                print("Weather service failure, url: \(url.absoluteString)")
                return nil
            }
        } catch {
            print("Error decoding api response: \(error.localizedDescription)")
            return nil
        }
    }
    
}
