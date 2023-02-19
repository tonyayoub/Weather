//
//  WeatherService.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-18.
//

import Foundation
import CoreLocation

struct WeatherService {
    let apiKey = "3kAMML3a9G33tK3gTVQ0BDFlZZyRGq79"
    
    func loadWeather(location: CLLocation) async throws -> Double? {
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
                let randomDouble = Double.random(in: -3...3)
                return simulatedData.data.timelines[0].intervals[0].values.temperature + randomDouble
            }
        } catch {
            return nil
        }
    }
    
    private var simulatedData: Weather
    {
        return try! JSONDecoder().decode(Weather.self, from: """
                {
                    "data": {
                        "timelines": [{
                            "timestep": "1h",
                            "endTime": "2023-02-17T16:00:00Z",
                            "startTime": "2023-02-17T10:00:00Z",
                            "intervals": [{
                                "startTime": "2023-02-17T10:00:00Z",
                                "values": {
                                    "temperature": 13.13,
                                    "weatherCode": 1001
                                }
                            }, {
                                "startTime": "2023-02-17T11:00:00Z",
                                "values": {
                                    "temperature": 12.43,
                                    "weatherCode": 1001
                                }
                            }, {
                                "startTime": "2023-02-17T12:00:00Z",
                                "values": {
                                    "temperature": 12.5,
                                    "weatherCode": 1001
                                }
                            }, {
                                "startTime": "2023-02-17T13:00:00Z",
                                "values": {
                                    "temperature": 13.28,
                                    "weatherCode": 1001
                                }
                            }, {
                                "startTime": "2023-02-17T14:00:00Z",
                                "values": {
                                    "temperature": 14.43,
                                    "weatherCode": 4200
                                }
                            }, {
                                "startTime": "2023-02-17T15:00:00Z",
                                "values": {
                                    "temperature": 14.69,
                                    "weatherCode": 4001
                                }
                            }, {
                                "startTime": "2023-02-17T16:00:00Z",
                                "values": {
                                    "temperature": 15.39,
                                    "weatherCode": 4001
                                }
                            }]
                        }]
                    }
                }
                """.data(using: .utf8)!)
        
        
    }
}
