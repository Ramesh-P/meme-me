//
//  SentMemesCollectionViewController.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 12/2/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Properties
    let navigationControllerDelegate = AppNavigationControllerDelegate()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var canEdit: Bool = Bool()

    // MARK: Outlets
    @IBOutlet weak var sentMemesCollection: UICollectionView!
    @IBOutlet weak var editItemButton: UIBarButtonItem!
    
    // MARK: Overrides
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialize
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(gesture:)))
        sentMemesCollection.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Initialize
        canEdit = false
        editItemButton.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 16)!], for: UIControlState.normal)
        sentMemesCollection.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        
        // Display app title
        navigationControllerDelegate.setBackgroundImage(self)
        
        // Layout cells
        var itemsPerRow: CGFloat = 0.0
        var size: CGFloat = 0.0
        let flowLayout = sentMemesCollection.collectionViewLayout as? UICollectionViewFlowLayout
        
        if UIDevice.current.orientation.isPortrait {
            itemsPerRow = 3.0
        } else {
            itemsPerRow = 5.0
        }
        
        size = UIScreen.main.bounds.size.width / itemsPerRow
        flowLayout?.itemSize = CGSize(width: size, height: size + 64)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Reset
        canEdit = false
        editItemButton.title = "Edit"
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Enable edit
        if appDelegate.memes.count == 0 {
            editItemButton.title = "Edit"
            editItemButton.isEnabled = false
        } else {
            editItemButton.isEnabled = true
        }
        
        return appDelegate.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Initialize
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath)
        let meme = appDelegate.memes[indexPath.row]
        
        let sentMeme: UIImageView = (cell.contentView.viewWithTag(100) as? UIImageView)!
        let topCaption: UILabel = (cell.contentView.viewWithTag(101) as? UILabel)!
        let bottomCaption: UILabel = (cell.contentView.viewWithTag(102) as? UILabel)!
        let deleteButton: UIButton = (cell.contentView.viewWithTag(103) as? UIButton)!
        
        // Format
        cell.contentView.layer.borderColor = UIColor(red: 28.0/255, green: 35.0/255, blue: 45.0/255, alpha: 1.0).cgColor
        cell.contentView.layer.borderWidth = 2.0
        
        deleteButton.layer.setValue(indexPath.item, forKey: "index")
        deleteButton.addTarget(self, action: #selector(SentMemesCollectionViewController.deleteMeme(_:)), for: UIControlEvents.touchUpInside)
        deleteButton.isExclusiveTouch = true
        deleteButton.bringSubview(toFront: cell.contentView)
        
        if (canEdit) {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                deleteButton.alpha = 1
                deleteButton.isEnabled = true
            }, completion: nil)
        } else {
            deleteButton.alpha = 0
            deleteButton.isEnabled = false
        }
        
        // Present
        sentMeme.image = meme.originalImage
        topCaption.text = (meme.topCaption != "") ? meme.topCaption : "NO CAPTION"
        bottomCaption.text = (meme.bottomCaption != "") ? meme.bottomCaption : "NO CAPTION"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        if (canEdit) {
            return true
        }
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Reorder meme
        let meme = appDelegate.memes[sourceIndexPath.row]
        appDelegate.memes.remove(at: sourceIndexPath.row)
        appDelegate.memes.insert(meme, at: destinationIndexPath.row)
        
        // Refresh
        sentMemesCollection.reloadData()
    }
    
    // MARK: Functions
    func longPressGesture(gesture: UILongPressGestureRecognizer) {
        
        // Gesture actions
        let sourceIndexPath = sentMemesCollection.indexPathForItem(at: gesture.location(in: sentMemesCollection))
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            sentMemesCollection.beginInteractiveMovementForItem(at: sourceIndexPath!)
        case UIGestureRecognizerState.changed:
            sentMemesCollection.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case UIGestureRecognizerState.ended:
            sentMemesCollection.endInteractiveMovement()
        default:
            sentMemesCollection.cancelInteractiveMovement()
        }
    }
    
    // MARK: Action
    @IBAction func deleteMeme(_ sender: UIButton) {
        
        // Delete meme from list
        let index: Int = (sender.layer.value(forKey: "index")) as! Int
        appDelegate.memes.remove(at: index)
        
        // Refresh
        sentMemesCollection.reloadData()
    }
    
    @IBAction func toggleEdit(_ sender: UIBarButtonItem) {
        
        canEdit = !canEdit
        
        // Enable edit
        if (canEdit) {
            editItemButton.title = "Done"
        } else {
            editItemButton.title = "Edit"
        }
        
        // Refresh
        sentMemesCollection.reloadData()
    }
    
    // MARK: Exit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Display meme editor
        if (segue.identifier == "collectionToAddMeme") {
            let navigationController = segue.destination as! UINavigationController
            let destinationViewController = navigationController.topViewController as! MemeEditorViewController
            destinationViewController.editorMode = "Add"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Display selected meme detail
        if (!canEdit) {
            let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
            detailViewController.index = indexPath.row
            self.navigationController!.pushViewController(detailViewController, animated: true)
        }
    }
}

