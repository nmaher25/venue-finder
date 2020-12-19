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
        static let darkBlue = UIColor.rgb(red: 0, green: 9, blue: 138)
        static let successGreen = UIColor.rgb(red: 34, green: 242, blue: 34)
        static let errorRed = UIColor.rgb(red: 232, green: 41, blue: 12)
        
        static let pinkMain = UIColor.rgb(red: 243, green: 143, blue: 144)
        static let lightPinkDetail = UIColor.rgb(red: 244, green: 173, blue: 156)
        static let verylightPinkDetail = UIColor.rgb(red: 246, green: 218, blue: 203)
        
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
