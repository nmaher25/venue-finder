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
        static let successGreen = UIColor.rgb(red: 34, green: 242, blue: 34)
        static let errorRed = UIColor.rgb(red: 232, green: 41, blue: 12)
        
        static let pinkMain = UIColor.rgb(red: 243, green: 143, blue: 144)
        static let lightPinkDetail = UIColor.rgb(red: 244, green: 173, blue: 156)
        static let verylightPinkDetail = UIColor.rgb(red: 246, green: 218, blue: 203)
        
        static let textNormal = UIColor.black
        static let textLight = UIColor.rgb(red: 128, green: 128, blue: 128)
    }
    
    struct Margin {
        static let small: CGFloat = 5
        static let medium: CGFloat = 10
        static let large: CGFloat = 20
    }
    
    struct Font {
        static let smallNormal = UIFont.systemFont(ofSize: 12)
        static let smallBold = UIFont.boldSystemFont(ofSize: 12)
        
        static let mediumNormal = UIFont.systemFont(ofSize: 16)
        static let mediumBold = UIFont.boldSystemFont(ofSize: 16)
        
        static let largeNormal = UIFont.systemFont(ofSize: 20)
        static let largeBold = UIFont.boldSystemFont(ofSize: 20)
        
        static let xLargeNormal = UIFont.systemFont(ofSize: 24)
        static let xLargeBold = UIFont.boldSystemFont(ofSize: 24)
    }
}
