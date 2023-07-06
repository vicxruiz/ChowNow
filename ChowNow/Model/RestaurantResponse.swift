//
//  RestaurantResponse.swift
//  ChowNow
//
//  Created by Victor Ruiz on 7/6/23.
//

import Foundation

// MARK: - Response
struct RestaurantResponse: Codable, Equatable, Hashable {
    let id: String
    let locations: [Location]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case locations = "locations"
    }
}

// MARK: - Address
struct Address: Codable, Equatable, Hashable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let name: String?
    let formattedAddress: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
        case formattedAddress = "formatted_address"
    }
}

// MARK: - Location
struct Location: Codable, Equatable, Hashable {
    let id: String
    let address: Address
    let name: String
    let cuisines: [String]
    let phone: String
    let fulfillment: Fulfillment

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case address = "address"
        case name = "name"
        case cuisines = "cuisines"
        case phone = "phone"
        case fulfillment = "fulfillment"
    }
}

struct Fulfillment: Codable, Equatable, Hashable {
    let pickup: Pickup
}

// MARK: - Pickup
struct Pickup: Codable, Equatable, Hashable {
    let displayHours: [DisplayHour]

    enum CodingKeys: String, CodingKey {
        case displayHours = "display_hours"
    }
}

// MARK: - Range
struct Range: Codable, Equatable, Hashable {
    let from: String
    let to: String
    let label: String?

    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
        case label = "label"
    }
}

// MARK: - DisplayHour
struct DisplayHour: Codable, Equatable, Hashable {
    let dayId: Int
    let dow: String
    let ranges: [Range]

    enum CodingKeys: String, CodingKey {
        case dayId = "day_id"
        case dow = "dow"
        case ranges = "ranges"
    }
}
