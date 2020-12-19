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
    }
}
