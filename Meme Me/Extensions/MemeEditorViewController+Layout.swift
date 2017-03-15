//
//  MemeEditorViewController+Layout.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/10/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// MARK: MemeEditorViewController+Layout
extension MemeEditorViewController {
    
    // MARK: Functions
    func addImageBorder() {
        
        if memeImageView.image != nil {
            
            // Get resized image size
            let resizedImageView = UIImageView()
            resizedImageView.frame = AVMakeRect(aspectRatio: (memeImageView.image?.size)!, insideRect: memeImageView.frame)
            
            // Set border
            memeImageBorder.removeFromSuperlayer()
            memeImageBorder.frame = resizedImageView.frame
            memeImageBorder.borderColor = UIColor.white.cgColor
            memeImageBorder.borderWidth = 4.0
            memeEditorView.layer.addSublayer(memeImageBorder)
        }
    }
    
    func removeImageBorder() {
        
        // Remove border
        memeImageBorder.removeFromSuperlayer()
        if UIDevice.current.orientation.isPortrait {
            memeImageBorder.frame = CGRect(x: memeEditorView.center.x, y: memeEditorView.center.y, width: 0, height: 0)
        } else {
            memeImageBorder.frame = CGRect(x: memeEditorView.center.y, y: memeEditorView.center.x, width: 0, height: 0)
        }
        memeImageBorder.backgroundColor = UIColor.clear.cgColor
    }
    
    func layoutTextFields() {
        
        // Set caption field height
        for textField in self.textFields {
            textField.frame.size.height = MemeEditorViewController.overlayButtonSize
        }
        
        // Set caption field width
        let imageView = UIImageView()
        
        if memeImageView.image == nil {
            imageView.frame = memeEditorView.frame
        } else {
            imageView.frame = AVMakeRect(aspectRatio: (memeImageView.image?.size)!, insideRect: memeImageView.frame)
        }
        
        let width = imageView.frame.width
        let margin: CGFloat = 20.0
        
        for textField in self.textFields {
            textField.frame.size.width = width - margin
            textField.center.x = imageView.center.x
        }

        // Set spacer height
        let currentScreenHeight = UIScreen.main.bounds.size.height
        let screenHeight = UIViewController.ScreenHeight.self
        var space = CGFloat()
        
        if memeImageView.image == nil {
            switch currentScreenHeight {
            case screenHeight.PhoneSE.Landscape.rawValue, screenHeight.Phone.Landscape.rawValue:
                space = 32.0
            default:
                space = 44.0
            }
        } else {
            space = 15.0
        }
        
        // Layout caption fields
        let y = imageView.frame.origin.y
        let height = imageView.frame.height
        
        if memeImageView.image == nil {
            topCaption.frame.origin.y = space
            bottomCaption.frame.origin.y = height - (MemeEditorViewController.overlayButtonSize + space)
        } else {
            topCaption.frame.origin.y = y + space
            bottomCaption.frame.origin.y = (y + height) - (MemeEditorViewController.overlayButtonSize + space)
        }
    }
    
    func prepareToLaunchEditor() {
        
        /**
         * UI Element(s) State:
         *
         * Camera Button = Enable for Device / Disable for Simulator
         */
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
    
    func prepareToAddMeme() {
        
        /**
         * UI Element(s) State:
         *
         * Share Button = Disable
         * Cancel Button = Enable
         * Camera Button = As Set at Launch
         * Album Button = Enable
         * Image = nil
         * Top Caption = Empty
         * Bottom Caption = Empty
         */
        
        shareButton.isEnabled = false
    }
    
    func prepareToEditMeme() {
        
        /**
         * UI Element(s) State:
         *
         * Share Button = Enable
         * Cancel Button = Enable
         * Camera Button = Disable
         * Album Button = Disable
         * Image = Some Image
         * Top Caption = Some Text
         * Bottom Caption = Some Text
         */
        
        shareButton.isEnabled = true
        cameraButton.isEnabled = false
        albumButton.isEnabled = false
        memeImageView.image = appDelegate.memes[index].originalImage
        topCaption.text = appDelegate.memes[index].topCaption
        bottomCaption.text = appDelegate.memes[index].bottomCaption
    }
    
    func prepareToExitEditor() {
        
        /**
         * UI Element(s) State (for MemeMe 1.0 only, N/A for 2.0):
         *
         * Share Button = Disable
         * Image = nil
         * Top Caption = Empty
         * Bottom Caption = Empty
         */
        
        shareButton.isEnabled = false
        memeImageView.image = nil
        topCaption.text = ""
        bottomCaption.text = ""
    }
}

