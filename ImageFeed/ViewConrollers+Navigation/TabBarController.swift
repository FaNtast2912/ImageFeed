//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 13.10.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Private Properties
    private enum TapBarIdentifiers: String {
        case imagesListViewController = "ImagesListViewController"
        case profileViewController = "ProfileViewController"
    }
    // MARK: - Overrides Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: TapBarIdentifiers.imagesListViewController.rawValue)
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
                       title: "",
                       image: UIImage(named: "profileScreenActive"),
                       selectedImage: nil
                   )
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}