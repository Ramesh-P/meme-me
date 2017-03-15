//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 12/2/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Properties
    let navigationControllerDelegate = AppNavigationControllerDelegate()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let memeImageBorder = CALayer()
    var index: Int = Int()
    static var memedImage: UIImage!
    
    // MARK: Outlets
    @IBOutlet weak var toolbarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var memeDetailView: UIView!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: Overrides
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Display selected meme
        memeImageView.image = appDelegate.memes[index].memedImage
        displayFavorite()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // Initialize layout
        maintainConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        // Set toolbar height constraints
        maintainConstraints()
        
        // Reset border
        coordinator.animate(alongsideTransition: { context in
            self.addImageBorder()
        }, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        
        // Display app title
        navigationControllerDelegate.setBackgroundImage(self)
        
        // Set toolbar height constraints
        maintainConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        
        // Add border
        addImageBorder()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        
        // Share meme
        shareMeme()
    }
    
    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        
        // Set favorite
        toggleFavorite()
    }
    
    // MARK: Exit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Display meme editor
        if (segue.identifier == "detailToEditMeme") {
            let navigationController = segue.destination as! UINavigationController
            let destinationViewController = navigationController.topViewController as! MemeEditorViewController
            destinationViewController.editorMode = "Edit"
            destinationViewController.index = index
        }
    }
}

