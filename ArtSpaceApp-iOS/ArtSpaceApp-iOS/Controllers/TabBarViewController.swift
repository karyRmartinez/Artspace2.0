//
//  TabBarViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    private lazy var firstViewController = UINavigationController(rootViewController: MainFeedViewController())
    private lazy var SecondViewController = UINavigationController(rootViewController: UploadImageViewController())
    private lazy var thirdViewController = UINavigationController(rootViewController: FavoritesViewController())
    private lazy var fourthViewController = UINavigationController(rootViewController: ProfileViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        SecondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 0)
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bookmark.fill"), tag: 0)
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle.fill"), tag: 0)
        self.viewControllers = [firstViewController,SecondViewController,thirdViewController,fourthViewController]
    }
}
