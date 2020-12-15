//
//  FoursquareService.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation

//Singleton
class FoursquareService {
    static let shared = FoursquareService()
    
    private init() { }
    
    public func getVenues(atLatitude lat: Double,
                          atLongitude long: Double,
                          forQuery query: String,
                          completion: @escaping([Venue], Error) -> Void) {
        
    }
}
