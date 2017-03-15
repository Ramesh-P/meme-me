//
//  MemeDetailViewController+Layout.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 12/2/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// MARK: MemeDetailViewController+Layout
extension MemeDetailViewController {
    
    // MARK: Functions
    func maintainConstraints() {
        
        // Get screen height
        let currentScreenHeight = UIScreen.main.bounds.size.height
        let screenHeight = UIViewController.ScreenHeight.self
        
        // Set spacer height constraints
        switch currentScreenHeight {
        case screenHeight.PhoneSE.Landscape.rawValue, screenHeight.Phone.Landscape.rawValue:
            toolbarHeightConstraint.constant = 32
        default:
            toolbarHeightConstraint.constant = 44
        }
    }
    
    func addImageBorder() {
        
        // Get resized image size
        let resizedImageView = UIImageView()
        resizedImageView.frame = AVMakeRect(aspectRatio: (memeImageView.image?.size)!, insideRect: memeImageView.frame)
        
        // Set border
        memeImageBorder.removeFromSuperlayer()
        memeImageBorder.frame = resizedImageView.frame
        memeImageBorder.borderColor = UIColor.white.cgColor
        memeImageBorder.borderWidth = 4.0
        memeDetailView.layer.addSublayer(memeImageBorder)
    }
    
    func removeImageBorder() {
        
        // Remove border
        memeImageBorder.removeFromSuperlayer()
        if UIDevice.current.orientation.isPortrait {
            memeImageBorder.frame = CGRect(x: memeDetailView.center.x, y: memeDetailView.center.y, width: 0, height: 0)
        } else {
            memeImageBorder.frame = CGRect(x: memeDetailView.center.y, y: memeDetailView.center.x, width: 0, height: 0)
        }
        memeImageBorder.backgroundColor = UIColor.clear.cgColor
    }
}

