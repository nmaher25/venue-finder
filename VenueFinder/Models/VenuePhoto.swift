//
//  VenuePhoto.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/17/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation

struct PhotoResponse {
    let response: PhotosObject
    
    struct PhotosObject {
        let photos: VenuePhoto
    }
}

struct VenuePhoto {
    let count: Int
    let items: [PhotoInfo]?
    
    struct PhotoInfo {
        let id: String
        let prefix: String
        let suffix: String
        let width: Int
        let height: Int
    }
}
