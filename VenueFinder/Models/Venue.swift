//
//  Venue.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation

struct Response: Codable {
    let response: AllVenues
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    struct AllVenues: Codable {
        let venues: [Venue]
    }
}

struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
    
    struct Location: Codable {
        let address: String?
        let lat: Double
        let lng: Double
        let distance: Double?
        let postalCode: String?
        let cc: String?
        let city: String?
        let state: String
        let country: String?
        let formattedAddress: [String]?
    }
}
