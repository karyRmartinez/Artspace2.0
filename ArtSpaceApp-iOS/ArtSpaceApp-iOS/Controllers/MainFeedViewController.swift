//
//  MainFeedViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/20/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
    
    
    lazy var artCollectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout.init()
      let collectionView = UICollectionView(frame:.zero , collectionViewLayout: layout)
      layout.scrollDirection = .vertical
      layout.itemSize = CGSize(width: 250, height: 250)
      return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
