//
//  MemeEditorTextFieldDelegate.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/11/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeEditorTextFieldDelegate
class MemeEditorTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: Functions
    func fontName() -> String {
        
        // Get font name
        let currentFontName = MemeEditorViewController.fontName
        let fontName = UIViewController.FontName.self
        
        // Set font name
        var name: String = String()
        
        switch currentFontName {
        case fontName.impact.rawValue:
            name = "Impact"
        case fontName.typewriter.rawValue:
            name = "AmericanTypewriter-CondensedBold"
        case fontName.chalkboard.rawValue:
            name = "ChalkboardSE-Bold"
        case fontName.futura.rawValue:
            name = "Futura-CondensedMedium"
        case fontName.sanFrancisco.rawValue:
            name = "SFCompactText-Heavy"
        default:
            break
        }
        
        return name
    }
    
    func fontSize(_ height: CGFloat) -> CGFloat {
        
        // Get screen height
        let currentScreenHeight = height
        let screenHeight = UIViewController.ScreenHeight.self
        
        // Set font size
        var size: CGFloat = 0
        
        switch currentScreenHeight {
        case screenHeight.PhoneSE.Portrait.rawValue:
            size = 32
        case screenHeight.PhoneSE.Landscape.rawValue:
            size = 22
        case screenHeight.Phone.Portrait.rawValue:
            size = 36
        case screenHeight.Phone.Landscape.rawValue:
            size = 24
        case screenHeight.PhonePlus.Portrait.rawValue:
            size = 40
        case screenHeight.PhonePlus.Landscape.rawValue:
            size = 26
        default:
            break
        }
        
        return size
    }
    
    func fontColor() -> UIColor {
        
        // Get font color
        let currentFontColor = MemeEditorViewController.fontColor
        let fontColor = UIViewController.FontColor.self
        
        // Set font color
        var color: UIColor = UIColor()
        
        switch currentFontColor {
        case fontColor.white.rawValue:
            color = UIColor.white
        case fontColor.red.rawValue:
            color = UIColor.red
        case fontColor.yellow.rawValue:
            color = UIColor.yellow
        case fontColor.cyan.rawValue:
            color = UIColor.cyan
        case fontColor.green.rawValue:
            color = UIColor.green
        default:
            break
        }
        
        return color
    }
    
    func fontStyle(_ textField: UITextField, height: CGFloat) {
        
        // Set font style
        let color = fontColor()
        let name = fontName()
        let size = fontSize(height)
        
        let textAttributes = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: UIFont(name: name, size: size)!,
            NSStrokeWidthAttributeName: -6.0,
            ] as [String : Any]
        
        textField.defaultTextAttributes = textAttributes
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 17
        textField.textAlignment = .center
        
        MemeEditorViewController.overlayButtonSize = size + 12
    }
    
    // MARK: Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Set font
        let currentScreenHeight = UIScreen.main.bounds.size.height
        fontStyle(textField, height: currentScreenHeight)
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // Set font
        let currentScreenHeight = UIScreen.main.bounds.size.height
        fontStyle(textField, height: currentScreenHeight)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Set text field background color
        textField.backgroundColor = UIColor.clear
        
        // Enable sharing
        MemeEditorViewController.enableShareButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Dismiss keyboard
        textField.resignFirstResponder()
        return true
    }
}

