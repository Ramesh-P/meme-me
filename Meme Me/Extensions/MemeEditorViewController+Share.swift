//
//  MemeEditorViewController+Share.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/19/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// MARK: MemeEditorViewController+Share
extension MemeEditorViewController {

    // MARK: Functions
    func presentActivityView() {
        
        // Initialize
        MemeEditorViewController.memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [MemeEditorViewController.memedImage], applicationActivities: nil)
        
        // Save sent meme
        activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) -> Void in
            if completed {
                self.saveSentMeme()
            } else {
                print("Cancelled")
            }
        }
        
        // Present
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Prepare
        prepareMemeImage()
        
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
        resetMemeEditor()
        
        return memedImage
    }
    
    func prepareMemeImage() {
        
        // Prepare
        for textField in textFields {
            textField.clearButtonMode = .never
            textField.attributedPlaceholder = NSAttributedString(string: "")
            textField.isEnabled = false
        }
        
        removeImageBorder()
    }
    
    func resetMemeEditor() {
        
        // Reset
        for textField in textFields {
            textField.clearButtonMode = .unlessEditing
            textField.attributedPlaceholder = NSAttributedString(string: "CAPTION")
            textField.isEnabled = true
        }
        
        addImageBorder()
    }
    
    func saveSentMeme() {
        
        let meme = Meme(topCaption: topCaption.text!, bottomCaption: bottomCaption.text!, originalImage: memeImageView.image!, memedImage: MemeEditorViewController.memedImage, fontName: MemeEditorViewController.fontName, fontColor: MemeEditorViewController.fontColor, favorite: false)
        
        // Save to meme array
        if editorMode == "Add" {
            appDelegate.memes.append(meme)
        } else if editorMode == "Edit" {
            appDelegate.memes[index].topCaption = meme.topCaption
            appDelegate.memes[index].bottomCaption = meme.bottomCaption
            appDelegate.memes[index].memedImage = meme.memedImage
            appDelegate.memes[index].fontName = meme.fontName
            appDelegate.memes[index].fontColor = meme.fontColor
        }
        
        // Dismiss
        self.performSegue(withIdentifier: "toSentMemes", sender: self)
    }
}

