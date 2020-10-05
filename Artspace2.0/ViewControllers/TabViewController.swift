//
//  TabViewController.swift
//  Artspace2.0
//
//  Created by Kary Martinez on 9/4/20.
//  Copyright © 2020 Artspace. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    lazy var FirstViewController = UINavigationController(rootViewController: FeedViewController())
    lazy var SecondViewController = UINavigationController(rootViewController: AddImageViewController())
    lazy var ThirdViewController = UINavigationController(rootViewController: FavoriteViewController())
     lazy var FourthViewController = UINavigationController(rootViewController: ProfileViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        FirstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        SecondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 0)
        ThirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bookmark.fill"), tag: 0)
        FourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle.fill"), tag: 0)
        self.viewControllers = [FirstViewController,SecondViewController,ThirdViewController,FourthViewController]

        
    }
    

}
