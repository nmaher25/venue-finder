//
//  Styler.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/16/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit

struct Styler {
    struct Color {
        static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
        
        static let textNormal = UIColor.black
        static let textLight = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    
    struct Font {
        static let titleFont = UIFont(name: "Didot", size: 16)
        static let titleBoldFont = UIFont(name: "Didot-Bold", size: 16)
        static let bodyFont = UIFont(name: "Didot", size: 12)
        static let bodyBoldFont = UIFont(name: "Didot-Bold", size: 12)
    }
}
