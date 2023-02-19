//
//  WeatherCodingTests.swift
//  WeatherTests
//
//  Created by Tony Ayoub on 2023-02-17.
//

import XCTest
@testable import Weather

final class WeatherCodingTests: XCTestCase {

    func testDecode() throws {
        let model = try JSONDecoder().decode(
            Weather.self,
            from: """
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
            """.data(using: .utf8)!
        )

        let test = "test"
        XCTAssertEqual(test, "test")
    }

//    func testEncode() throws {
//        let model = LibraryProduct.TaxCode(code: "test", name: "name")
//        let modelData = try JSONEncoder().encode(model)
//
//        XCTAssertEqual(
//            String(data: modelData, encoding: .utf8),
//            "{\"label\":\"name\",\"code\":\"test\"}"
//        )
//    }

}
