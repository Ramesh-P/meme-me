//
//  MemeEditorViewController+Color.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/16/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeEditorViewController+Color
extension MemeEditorViewController {
    
    // MARK: Functions
    func setColorOverlay() {
        
        // Set caption textfiled color overlay
        for textField in textFields {
            textField.rightView = colorOverlayButton()
            //textField.rightViewMode = .always
            textField.rightViewMode = .whileEditing
        }
    }
    
    func colorOverlayButton() -> UIButton {
        
        // Create color overlay button
        let overlayButton = UIButton(type: .custom)
        overlayButton.addTarget(self, action: #selector(self.displayColor(_:)), for: .touchUpInside)
        
        overlayButton.frame = CGRect(x: 0, y: 0, width: MemeEditorViewController.overlayButtonSize, height: MemeEditorViewController.overlayButtonSize)
        overlayButton.setImage(UIImage(named: "Color"), for: .normal)
        overlayButton.adjustsImageWhenHighlighted = false
        
        return overlayButton
    }
    
    func displayColor(_ sender:UIButton!) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Select color
        let whiteSelected = UIAlertAction(title: "White", style: .default) { (action) in
            MemeEditorViewController.fontColor = 0
            self.changeFontColor()
        }
        alertController.addAction(whiteSelected)
        
        let redSelected = UIAlertAction(title: "Red", style: .default) { (action) in
            MemeEditorViewController.fontColor = 1
            self.changeFontColor()
        }
        alertController.addAction(redSelected)
        
        let yellowSelected = UIAlertAction(title: "Yellow", style: .default) { (action) in
            MemeEditorViewController.fontColor = 2
            self.changeFontColor()
        }
        alertController.addAction(yellowSelected)
        
        let cyanSelected = UIAlertAction(title: "Cyan", style: .default) { (action) in
            MemeEditorViewController.fontColor = 3
            self.changeFontColor()
        }
        alertController.addAction(cyanSelected)
        
        let greenSelected = UIAlertAction(title: "Green", style: .default) { (action) in
            MemeEditorViewController.fontColor = 4
            self.changeFontColor()
        }
        alertController.addAction(greenSelected)
        
        // Cancel color selection
        let cancelSelected = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelSelected)
        
        // --Color: Action--
        alertController.view.tintColor = UIColor(red: 206.0/255, green: 35.0/255, blue: 37.0/255, alpha: 1.0)
        
        // Present colors panel
        self.present(alertController, animated: true) {
            
        }
        
        // --Color: Cancel--
        let subview = alertController.view.subviews.last
        subview?.subviews.last?.tintColor = UIColor(red: 121.0/255, green: 216.0/255, blue: 222.0/255, alpha: 1.0)
    }
}

