//
//  MemeEditorViewController+ImagePicker.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/18/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeEditorViewController+ImagePicker
extension MemeEditorViewController {
    
    // MARK: Functions
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        
        // Set image source
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        
        // Set image picker appearance
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = UIColor.white
        imagePicker.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(red: 28.0/255, green: 35.0/255, blue: 45.0/255, alpha: 1.0),
            NSFontAttributeName: UIFont(name: "Arial-BoldMT", size: 18)!
        ]
        imagePicker.navigationBar.tintColor = UIColor(red: 237.0/255, green: 63.0/255, blue: 54.0/255, alpha: 1.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSForegroundColorAttributeName: UIColor(red: 121.0/255, green: 216.0/255, blue: 222.0/255, alpha: 1.0),
            //NSFontAttributeName: UIFont(name: "ArialMT", size: 16)!
            NSFontAttributeName: UIFont(name: "Arial-BoldMT", size: 16)!
            ], for: UIControlState.normal)
        
        // Present image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Pick image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
            addImageBorder()
            
            // Dismiss
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss
        self.dismiss(animated: true, completion: nil)
    }
}

