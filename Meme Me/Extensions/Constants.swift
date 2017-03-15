//
//  Constants.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/15/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

// MARK: Structures
struct Meme {
    var topCaption = String()
    var bottomCaption = String()
    var originalImage = UIImage()
    var memedImage = UIImage()
    var fontName = Int()
    var fontColor = Int()
    var favorite = Bool()
}

// MARK: Constants
extension UIViewController {
    
    // MARK: Types
    enum ScreenHeight {
        enum PhoneSE: CGFloat {
            case Portrait = 568.0
            case Landscape = 320.0
        }
        
        enum Phone: CGFloat {
            case Portrait = 667.0
            case Landscape = 375.0
        }
        
        enum PhonePlus: CGFloat {
            case Portrait = 736.0
            case Landscape = 414.0
        }
    }
    
    enum FontName: Int {
        case impact
        case typewriter
        case chalkboard
        case futura
        case sanFrancisco
    }
    
    enum FontColor: Int {
        case white
        case red
        case yellow
        case cyan
        case green
    }
}

