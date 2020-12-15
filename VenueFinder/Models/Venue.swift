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
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.response = try valueContainer.decode(AllVenues.self, forKey: CodingKeys.response)
    }
}

struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
    
    /*
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
    }*/
    
    struct Location: Codable {
        let address: String?
        let lat: Double?
        let lng: Double?
        let distance: Double?
        let postalCode: String?
        let cc: String?
        let city: String?
        let state: String?
        let country: String?
        let formattedAddress: [String]?
        
        /*
        enum CodingKeys: String, CodingKey {
            case address
            case lat
            case lng
            case distance
            case postalCode
            case cc
            case city
            case state
            case country
            case formattedAddress
        }*/
    }
}
