//
//  Weather.swift
//  Weather
//
//  Created by Tony Ayoub on 2023-02-17.
//

struct Weather: Codable {
    let data: WeatherData
}

struct WeatherData: Codable {
    let timelines: [Timeline]
}

struct Timeline: Codable {
    let timestep: String
    let startTime: String
    let endTime: String
    let intervals: [Interval]
}

struct Interval: Codable {
    let startTime: String
    let values: IntervalValue
}

struct IntervalValue: Codable {
    var temperature: Double
    var weatherCode: Int
}
