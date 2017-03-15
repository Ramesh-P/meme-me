//
//  AppNavigationControllerDelegate.swift
//  Meme Me
//
//  Created by Ramesh Parthasarathy on 11/9/16.
//  Copyright © 2016 Ramesh Parthasarathy. All rights reserved.
//

import Foundation
import UIKit

// MARK: AppNavigationControllerDelegate
class AppNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    // MARK: Setup Title
    func setBackgroundImage(_ viewController: UIViewController) {
        
        // Get screen height
        let currentScreenHeight = UIScreen.main.bounds.size.height
        let screenHeight = UIViewController.ScreenHeight.self
        
        // Display app title
        switch currentScreenHeight {
        case screenHeight.PhoneSE.Portrait.rawValue:
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "AppTitleImage-568h-Portrait"), for: .default)
        case screenHeight.PhoneSE.Landscape.rawValue:
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "AppTitleImage-568h-Landscape"), for: .default)
        case screenHeight.Phone.Portrait.rawValue, screenHeight.PhonePlus.Portrait.rawValue:
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "AppTitleImage-Portrait")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        case screenHeight.Phone.Landscape.rawValue, screenHeight.PhonePlus.Landscape.rawValue:
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "AppTitleImage-Landscape")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        default:
            break
        }
    }
}

