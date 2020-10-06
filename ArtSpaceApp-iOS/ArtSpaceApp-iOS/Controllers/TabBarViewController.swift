//
//  TabBarViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    lazy var firstViewController = UINavigationController(rootViewController: FeedViewController())
    lazy var SecondViewController = UINavigationController(rootViewController: UploadImageViewController())
    lazy var thirdViewController = UINavigationController(rootViewController: FavoritesViewController())
    lazy var fourthViewController = UINavigationController(rootViewController: ProfileViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        SecondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 0)
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bookmark.fill"), tag: 0)
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle.fill"), tag: 0)
        self.viewControllers = [firstViewController,SecondViewController,thirdViewController,fourthViewController]
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
