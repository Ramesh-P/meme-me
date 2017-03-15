//
//  SentMemesTableViewController.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 12/2/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    let navigationControllerDelegate = AppNavigationControllerDelegate()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var canEdit: Bool = Bool()
    
    // MARK: Outlets
    @IBOutlet weak var sentMemesTable: UITableView!
    @IBOutlet weak var editRowButton: UIBarButtonItem!
    
    // MARK: Overrides
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // Initialize
        canEdit = false
        editRowButton.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 16)!], for: UIControlState.normal)
        
        // Refresh
        sentMemesTable.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        
        // Display app title
        navigationControllerDelegate.setBackgroundImage(self)
        
        // Set row height
        if UIDevice.current.orientation.isPortrait {
            sentMemesTable.rowHeight = 88.0
        } else {
            sentMemesTable.rowHeight = 66.0
        }
        
        // Layout separator
        for tag in 0...appDelegate.memes.count {
            let separator = self.view.viewWithTag(tag + 1000)
            separator?.removeFromSuperview()
        }
        
        for row in 0...appDelegate.memes.count {
            let separator: UIView = UIView()
            let separatorWidth = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 1.25
            let separatorY = sentMemesTable.rowHeight - 2
            separator.tag = row + 1000
            separator.frame = CGRect(x: 0, y: separatorY, width: separatorWidth, height: 2)
            separator.backgroundColor = UIColor(red: 28.0/255, green: 35.0/255, blue: 45.0/255, alpha: 1.0)
            
            let indexPath = NSIndexPath(row: row, section: 0)
            sentMemesTable.cellForRow(at: indexPath as IndexPath)?.contentView.addSubview(separator)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Reset
        sentMemesTable.setEditing(false, animated: false)
        editRowButton.title = "Edit"
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Enable edit
        if appDelegate.memes.count == 0 {
            editRowButton.title = "Edit"
            editRowButton.isEnabled = false
        } else {
            editRowButton.isEnabled = true
        }
        
        return appDelegate.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Initialize
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as UITableViewCell
        let meme = appDelegate.memes[indexPath.row]
        
        let thumbnail: UIImageView = (cell.contentView.viewWithTag(100) as? UIImageView)!
        let topCaption: UILabel = (cell.contentView.viewWithTag(101) as? UILabel)!
        let bottomCaption: UILabel = (cell.contentView.viewWithTag(102) as? UILabel)!
        
        // Present
        thumbnail.image = meme.originalImage
        topCaption.text = (meme.topCaption != "") ? meme.topCaption : "NO CAPTION"
        bottomCaption.text = (meme.bottomCaption != "") ? meme.bottomCaption : "NO CAPTION"

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete meme from list
        if editingStyle == UITableViewCellEditingStyle.delete {
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Reorder meme
        let meme = appDelegate.memes[sourceIndexPath.row]
        appDelegate.memes.remove(at: sourceIndexPath.row)
        appDelegate.memes.insert(meme, at: destinationIndexPath.row)
    }
    
    // MARK: Actions
    @IBAction func toggleEdit(_ sender: UIBarButtonItem) {
        
        canEdit = !canEdit
        
        // Enable edit
        if (canEdit) {
            sentMemesTable.setEditing(true, animated: true)
            editRowButton.title = "Done"
        } else {
            sentMemesTable.setEditing(false, animated: true)
            editRowButton.title = "Edit"
        }
    }
    
    // MARK: Exit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Display meme editor
        if (segue.identifier == "tableToAddMeme") {
            let navigationController = segue.destination as! UINavigationController
            let destinationViewController = navigationController.topViewController as! MemeEditorViewController
            destinationViewController.editorMode = "Add"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Display selected meme detail
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.index = indexPath.row
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func cancelToSentMemesViewController(segue:UIStoryboardSegue) {
        
    }
}

