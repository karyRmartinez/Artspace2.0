//
//  TabBarViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    private lazy var mainFeedVC = UINavigationController(rootViewController: MainFeedViewController())
    private lazy var uploadImageVC = UINavigationController(rootViewController: UploadImageViewController())
    private lazy var FavImagesVC = UINavigationController(rootViewController: FavoritesViewController())
    private lazy var profileVC = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainFeedVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        uploadImageVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 1)
        FavImagesVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bookmark.fill"), tag: 2)
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle.fill"), tag: 3)
        self.viewControllers = [mainFeedVC,uploadImageVC,FavImagesVC,profileVC]
    }
}
