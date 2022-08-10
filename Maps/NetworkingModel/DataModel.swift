//
//  DataModel.swift
//  Maps
//
//  Created by Юлия Филимонова on 09.08.2022.
//

import Foundation

struct DataModel: Codable {
    let points: [Point]
    let lines: [Line]

    enum CodingKeys: String, CodingKey {
            case points = "Points"
            case lines = "Lines"
        }
}

struct Point: Codable {
    let properties: PointProperties
}

struct PointProperties: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}

struct Line: Codable {
    let geometry: LineGeometry
}

struct LineGeometry: Codable {
    let coordinates: [[Double]]
}
