//
//  MemeEditorViewController.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/6/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Properties
    let navigationControllerDelegate = AppNavigationControllerDelegate()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let textFieldDelegate = MemeEditorTextFieldDelegate()
    var editorMode: String!
    var index: Int = Int()
    let memeImageBorder = CALayer()
    var textFields: [UITextField] = [UITextField]()
    static var fontName: Int = Int()
    static var fontColor: Int = Int()
    static var overlayButtonSize: CGFloat = CGFloat()
    static var memeImageSelected: Bool!
    static var memeTextEntered: Bool!
    static var captions: [UITextField]!
    static var shareMemeButton: UIBarButtonItem = UIBarButtonItem()
    static var memedImage: UIImage!
    
    // MARK: Outlets
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    //@IBOutlet weak var photoEditButton: UIBarButtonItem!
    @IBOutlet weak var memeEditorView: UIView!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topCaption: UITextField!
    @IBOutlet weak var bottomCaption: UITextField!
     
    // MARK: Type Methods
    class func enableShareButton() {
        
        // Check for meme caption
        MemeEditorViewController.memeTextEntered = false
        
        for caption in MemeEditorViewController.captions {
            if MemeEditorViewController.memeTextEntered == false {
                if caption.text?.isEmpty != true {
                    MemeEditorViewController.memeTextEntered = true
                }
            }
        }
        
        // Enable sharing
        if (MemeEditorViewController.memeImageSelected == true && MemeEditorViewController.memeTextEntered == true) {
            MemeEditorViewController.shareMemeButton.isEnabled = true
        } else {
            MemeEditorViewController.shareMemeButton.isEnabled = false
        }
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize
        topCaption.delegate = textFieldDelegate
        bottomCaption.delegate = textFieldDelegate
        textFields = [topCaption, bottomCaption]
        
        MemeEditorViewController.captions = [topCaption, bottomCaption]
        MemeEditorViewController.shareMemeButton = shareButton
        
        let clearButton = UIButton.appearance(whenContainedInInstancesOf: [UITextField.self])
        clearButton.setBackgroundImage(UIImage(named: "Clear"), for: .normal)
        
        if editorMode == "Add" {
            MemeEditorViewController.fontName = 0
            MemeEditorViewController.fontColor = 0
            MemeEditorViewController.memeImageSelected = false
            MemeEditorViewController.memeTextEntered = false
        } else if editorMode == "Edit" {
            MemeEditorViewController.fontName = appDelegate.memes[index].fontName
            MemeEditorViewController.fontColor = appDelegate.memes[index].fontColor
            MemeEditorViewController.memeImageSelected = true
            MemeEditorViewController.memeTextEntered = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Subscribe to keyboard notifications
        subscribeToKeyboardNotifications()
        
        // Initialize
        prepareToLaunchEditor()
        
        if editorMode == "Add" {
            prepareToAddMeme()
        } else if editorMode == "Edit" {
            prepareToEditMeme()
        }
        
        // Check for meme image
        if editorMode == "Add" {
            if memeImageView.image == nil {
                for textField in self.textFields {
                    textField.alpha = 1
                }
                MemeEditorViewController.memeImageSelected = false
            } else {
                for textField in self.textFields {
                    textField.alpha = 0
                }
                MemeEditorViewController.memeImageSelected = true
            }
            
            removeImageBorder()
            
            // Enable sharing
            MemeEditorViewController.enableShareButton()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        // Reset font height
        let currentScreenHeight = UIScreen.main.bounds.size.width
        textFieldDelegate.fontStyle(topCaption, height: currentScreenHeight)
        textFieldDelegate.fontStyle(bottomCaption, height: currentScreenHeight)
        
        // Resize overlay buttons
        for textField in textFields {
            textField.leftView?.layer.frame = CGRect(x: 0, y: 0, width: MemeEditorViewController.overlayButtonSize, height: MemeEditorViewController.overlayButtonSize)
            textField.rightView?.layer.frame = CGRect(x: 0, y: 0, width: MemeEditorViewController.overlayButtonSize, height: MemeEditorViewController.overlayButtonSize)
        }
        
        // Reset layout
        coordinator.animate(alongsideTransition: { context in
            self.addImageBorder()
            self.layoutTextFields()
        }, completion: nil)
        
        // Reposition textfield on device orientation change
        coordinator.animate(alongsideTransition: nil,
                            completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                                self.view.frame.origin.y = UIApplication.shared.statusBarFrame.height + UINavigationController().navigationBar.frame.size.height
        })
    }
    
    override func viewWillLayoutSubviews() {
        
        // Display app title
        navigationControllerDelegate.setBackgroundImage(self)
        
        // Reset font height
        let currentScreenHeight = UIScreen.main.bounds.size.height
        textFieldDelegate.fontStyle(topCaption, height: currentScreenHeight)
        textFieldDelegate.fontStyle(bottomCaption, height: currentScreenHeight)
        
        // Layout
        if memeImageView.image == nil {
            layoutTextFields()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        // Initialize layout
        if editorMode == "Edit" {
            addImageBorder()
            setFontOverlay()
            setColorOverlay()
            layoutTextFields()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // Initialize layout
        if editorMode == "Add" {
            addImageBorder()
            setFontOverlay()
            setColorOverlay()
            
            if memeImageView.image != nil {
                UIView.animate(withDuration: 0.0, animations: {
                    self.layoutTextFields()
                }, completion: { (finished: Bool) -> Void in
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        for textField in self.textFields {
                            textField.alpha = 1
                        }
                    }, completion: nil)
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Unsubscribe to keyboard notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        // Layout image
        removeImageBorder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Dismiss keyboard
        view.endEditing(true)
        
        // Enable sharing
        MemeEditorViewController.enableShareButton()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Functions
    func changeFont() {
        
        // Change font
        let currentScreenHeight = UIScreen.main.bounds.size.height
        let name = textFieldDelegate.fontName()
        let size = textFieldDelegate.fontSize(currentScreenHeight)
        
        for textField in textFields {
            textField.font = UIFont(name: name, size: size)
        }
    }
    
    func changeFontColor() {
        
        // Change font color
        let color = textFieldDelegate.fontColor()
        
        for textField in textFields {
            textField.textColor = color
        }
    }
    
    func subscribeToKeyboardNotifications() {
        
        // Add keyboard notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        // Reposition textfield on keyboard display
        if (bottomCaption.isFirstResponder) {
            view.frame.origin.y -= getKeyboardHeight(notification: notification) - UINavigationController().toolbar.frame.size.height
        }
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        
        // Apply textfield color
        if topCaption.isFirstResponder {
            topCaption.backgroundColor = UIColor.white
        } else if bottomCaption.isFirstResponder {
            bottomCaption.backgroundColor = UIColor.white
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        // Reposition textfield on keyboard dismiss
        if (view.frame.origin.y) < 0 {
            view.frame.origin.y += getKeyboardHeight(notification: notification) - UINavigationController().toolbar.frame.size.height
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        // Get keyboard height
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        // Remove keyboard notification observers
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    // MARK: Actions
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        
        // Display camera
        presentImagePicker(sourceType: .camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: UIBarButtonItem) {
        
        // Display photo album
        presentImagePicker(sourceType: .photoLibrary)
    }
    
    /*
    @IBAction func editPicture(_ sender: UIBarButtonItem) {
        
    }
 */
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        
        // Display share options
        presentActivityView()
    }
    
    @IBAction func exitMemeEditor(_ sender: UIBarButtonItem) {
        
        // Reset
        prepareToExitEditor()
        removeImageBorder()
        layoutTextFields()
        
        MemeEditorViewController.fontName = 0
        changeFont()
        
        MemeEditorViewController.fontColor = 0
        changeFontColor()
        
        MemeEditorViewController.memeImageSelected = false
        MemeEditorViewController.memeTextEntered = false
    }
}

