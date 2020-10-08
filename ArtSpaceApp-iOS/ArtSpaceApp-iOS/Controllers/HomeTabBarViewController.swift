//
//  TabBarViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    lazy var mainFeedVC = UINavigationController(rootViewController: MainFeedViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        mainFeedVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        self.viewControllers = [mainFeedVC]
    }
}
