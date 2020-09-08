//
//  DetailViewController.swift
//  Artspace2.0
//
//  Created by Kary Martinez on 9/8/20.
//  Copyright © 2020 Artspace. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var ArtImageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFit
        ImageView.backgroundColor = .clear
        return ImageView
    }()
    
    func addSubView() {
        self.view.addSubview(ArtImageView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
    }

}
