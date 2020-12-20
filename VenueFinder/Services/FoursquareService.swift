//
//  FoursquareService.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation

class FoursquareService {
    
    // Singleton declaration
    static let shared = FoursquareService()
    
    private init() { }
    
    fileprivate var versionDate: String = {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: 1606796389) // 12/1/2020
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }()
    
    var imageUrlCache: [String: URL] = [:]
    
    public func fetchVenues(atLatitude lat: Double,
                          atLongitude long: Double,
                          forQuery query: String,
                          completion: @escaping([Venue]?) -> Void,
                          errorCompletion: @escaping(ErrorResponse?) -> Void) {
        
        let baseUrl = URL(string: "https://api.foursquare.com/v2/venues/search")!
        let queryParams: [String: String] = [
            "ll": "\(lat),\(long)",
            "query": query,
            "limit": "10",
            "client_id": FOURSQUARE_CLIENT_ID,
            "client_secret": FOURSQUARE_CLIENT_SECRET,
            "v": versionDate
        ]
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let url = baseUrl.withQueries(queryParams)!
        let task = urlSession.dataTask(with: url) { (data, response, error) in //change this to our own custom session
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                if let venues = try? jsonDecoder.decode(Response.self, from: data) {
                    completion(venues.response.venues)
                    errorCompletion(nil)
                } else if let venueError = try? jsonDecoder.decode(ErrorResponse.self, from: data) {
                    completion(nil)
                    errorCompletion(venueError)
                }
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    public func fetchVenues(nearPlace near: String,
                            forQuery query: String,
                            completion: @escaping([Venue]?) -> Void,
                            errorCompletion: @escaping(ErrorResponse?) -> Void) {
        let baseUrl = URL(string: "https://api.foursquare.com/v2/venues/search")!
        let queryParams: [String: String] = [
            "near": "\(near)",
            "query": "\(query)",
            "limit": "10",
            "client_id": "\(FOURSQUARE_CLIENT_ID)",
            "client_secret": "\(FOURSQUARE_CLIENT_SECRET)",
            "v": "\(versionDate)"
        ]
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let url = baseUrl.withQueries(queryParams)!
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                if let venues = try? jsonDecoder.decode(Response.self, from: data) {
                    completion(venues.response.venues)
                    errorCompletion(nil)
                } else if let venueError = try? jsonDecoder.decode(ErrorResponse.self, from: data) {
                    completion(nil)
                    errorCompletion(venueError)
                }
            } else {
                completion(nil) 
                errorCompletion(nil)
            }
            
        }
        task.resume()
    }
    
    public func fetchVenueDetails(forVenueId venueId: String,
                                  completion: @escaping(Venue?) -> Void,
                                  errorCompletion: @escaping(ErrorResponse?) -> Void) {
        let baseUrl = URL(string: "https://api.foursquare.com/v2/venues/\(venueId)")!
        let queryParams: [String: String] = [
            "client_id": "\(FOURSQUARE_CLIENT_ID)",
            "client_secret": "\(FOURSQUARE_CLIENT_SECRET)",
            "v": "\(versionDate)"
        ]
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let url = baseUrl.withQueries(queryParams)!
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                if let venue = try? jsonDecoder.decode(ResponseDetail.self, from: data) {
                    completion(venue.response.venue)
                    errorCompletion(nil)
                } else if let venueError = try? jsonDecoder.decode(ErrorResponse.self, from: data) {
                    completion(nil)
                    errorCompletion(venueError)
                }
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    public func fetchVenuePhotos(forVenueId venueId: String,
                                 withLimit limit: Int,
                                 withOffset offset: Int,
                                 completion: @escaping(VenuePhoto?) -> Void) {
        let baseUrl = URL(string: "https://api.foursquare.com/v2/venues/\(venueId)/photos")!
        let queryParams: [String: String] = [
            "limit": "\(limit)",
            "offset": "\(offset)",
            "client_id": "\(FOURSQUARE_CLIENT_ID)",
            "client_secret": "\(FOURSQUARE_CLIENT_SECRET)",
            "v": "\(versionDate)"
        ]
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let url = baseUrl.withQueries(queryParams)!
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                if let venuePhoto = try? jsonDecoder.decode(PhotoResponse.self, from: data) {
                    completion(venuePhoto.response.photos)
                }
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
}
