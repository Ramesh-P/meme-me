//
//  MemeDetailViewController+Features.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 12/7/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// MARK: MemeDetailViewController+Features
extension MemeDetailViewController {
    
    // MARK: Functions
    func shareMeme() {
        
        // Initialize
        MemeDetailViewController.memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [MemeDetailViewController.memedImage], applicationActivities: nil)
        
        // Present
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Prepare
        removeImageBorder()
        
        // Render meme image
        let memedImageView = UIImageView()
        memedImageView.frame = AVMakeRect(aspectRatio: (memeImageView.image?.size)!, insideRect: memeImageView.frame)
        UIGraphicsBeginImageContextWithOptions(memedImageView.frame.size, false, UIScreen.main.scale)
        
        let imageContext: CGContext = UIGraphicsGetCurrentContext()!
        imageContext.concatenate(CGAffineTransform(translationX: -memedImageView.frame.origin.x, y: -memedImageView.frame.origin.y))
        self.view.layer.render(in: imageContext)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Reset
        addImageBorder()
        
        return memedImage
    }
    
    func displayFavorite() {
        
        // Display favorite status
        let favorite = appDelegate.memes[index].favorite
        
        if (favorite) {
            favoriteButton.image = UIImage(named: "Favorite-Selected")
        } else {
            favoriteButton.image = UIImage(named: "Favorite")
        }
    }
    
    func toggleFavorite() {
        
        // Set favorite status
        appDelegate.memes[index].favorite = !appDelegate.memes[index].favorite
        displayFavorite()
    }
}
