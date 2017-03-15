//
//  MemeEditorViewController+Fonts.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/15/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeEditorViewController+Fonts
extension MemeEditorViewController {
    
    // MARK: Functions
    func setFontOverlay() {
        
        // Set caption textfiled font overlay
        for textField in textFields {
            textField.leftView = fontOverlayButton()
            //textField.leftViewMode = .always
            textField.leftViewMode = .whileEditing
        }
    }
    
    func fontOverlayButton() -> UIButton {
        
        // Create font overlay button
        let overlayButton = UIButton(type: .custom)
        overlayButton.addTarget(self, action: #selector(self.displayFonts(_:)), for: .touchUpInside)
        
        overlayButton.frame = CGRect(x: 0, y: 0, width: MemeEditorViewController.overlayButtonSize, height: MemeEditorViewController.overlayButtonSize)
        overlayButton.setImage(UIImage(named: "Font"), for: .normal)
        overlayButton.adjustsImageWhenHighlighted = false
        
        return overlayButton
    }
    
    func displayFonts(_ sender:UIButton!) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Select fonts
        let impactSelected = UIAlertAction(title: "Impact", style: .default) { (action) in
            MemeEditorViewController.fontName = 0
            self.changeFont()
        }
        alertController.addAction(impactSelected)
        
        let americanTypewriterSelected = UIAlertAction(title: "American Typewriter", style: .default) { (action) in
            MemeEditorViewController.fontName = 1
            self.changeFont()
        }
        alertController.addAction(americanTypewriterSelected)
        
        let chalkboardSelected = UIAlertAction(title: "Chalkboard", style: .default) { (action) in
            MemeEditorViewController.fontName = 2
            self.changeFont()
        }
        alertController.addAction(chalkboardSelected)
        
        let futuraSelected = UIAlertAction(title: "Futura", style: .default) { (action) in
            MemeEditorViewController.fontName = 3
            self.changeFont()
        }
        alertController.addAction(futuraSelected)
        
        let sanFranciscoSelected = UIAlertAction(title: "San Francisco", style: .default) { (action) in
            MemeEditorViewController.fontName = 4
            self.changeFont()
        }
        alertController.addAction(sanFranciscoSelected)
        
        // Cancel font selection
        let cancelSelected = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelSelected)
        
        // --Color: Action--
        alertController.view.tintColor = UIColor(red: 206.0/255, green: 35.0/255, blue: 37.0/255, alpha: 1.0)
        
        // Present fonts panel
        self.present(alertController, animated: true) {
            
        }
        
        // --Color: Cancel--
        let subview = alertController.view.subviews.last
        subview?.subviews.last?.tintColor = UIColor(red: 121.0/255, green: 216.0/255, blue: 222.0/255, alpha: 1.0)
    }
}

