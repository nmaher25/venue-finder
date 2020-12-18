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
    
    struct AllVenues: Codable {
        let venues: [Venue]
    }
}

struct ResponseDetail: Codable {
    let response: VenueDetail
    
    struct VenueDetail: Codable {
        let venue: Venue
    }
}

struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
    let contact: Contact?
    let url: String?
    
    struct Location: Codable {
        let address: String?
        let lat: Double
        let lng: Double
        let distance: Double? //meters
        let postalCode: String?
        let cc: String?
        let city: String?
        let state: String?
        let country: String?
        let formattedAddress: [String]?
    }
    
    struct Contact: Codable {
        let phone: String?
        let formattedPhone: String?
        let twitter: String?
        let instagram: String?
        let facebook: String?
        let facebookUsername: String?
    }
}
