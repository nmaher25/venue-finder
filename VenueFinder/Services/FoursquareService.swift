//
//  FoursquareService.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation

// Singleton
class FoursquareService {
    static let shared = FoursquareService()
    
    private init() { }
    
    fileprivate var versionDate: String = {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: 1606796389) // 12/1/2020
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }()
    
    public func fetchVenues(atLatitude lat: Double,
                          atLongitude long: Double,
                          forQuery query: String,
                          completion: @escaping([Venue]?) -> Void) {
        
        let baseUrl = URL(string: "https://api.foursquare.com/v2/venues/search")!
        let queryParams: [String: String] = [
            "ll": "\(lat),\(long)",
            "query": query,
            "limit": "20",
            "cliend_id": FOURSQUARE_CLIENT_ID,
            "client_secret": FOURSQUARE_CLIENT_SECRET,
            "v": versionDate
        ]
        
        let url = baseUrl.withQueries(queryParams)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in //change this to our own custom session 
            let jsonDecoder = JSONDecoder()
            
            if let data = data, let venues = try? jsonDecoder.decode(Response.self, from: data) {
                completion(venues.response.venues)
            } else if let error = error {
                completion(nil) //add error message handling here
            }
            
        }
        task.resume()
    }
}
