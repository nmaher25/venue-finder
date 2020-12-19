//
//  VenueError.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/19/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let meta: VenueError
    
    struct VenueError: Codable {
        let code: Int
        let errorType: String
        let errorDetail: String
        /*
        enum ErrorType: String, Codable {
            case invalid_auth
            case param_error
            case endpoint_error
            case not_authorized
            case rate_limit_exceeded
            case quota_exceeded
            case deprecated
            case server_error
        }*/
    }
}
