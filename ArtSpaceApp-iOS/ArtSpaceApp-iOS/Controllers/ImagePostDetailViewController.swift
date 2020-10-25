//
//  ImagePostDetailViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/24/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class ImagePostDetailViewController: UIViewController {
    //MARK: - Properties
//    var selectedArtObject: ArtObject!
    
    // MARK: - UI Objects
    private lazy var artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var imageDescription: UILabel = {
         let description = UILabel()
        description.textAlignment = .justified
         description.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae justo eget magna fermentum iaculis eu. Sed blandit libero volutpat sed cras ornare arcu. Id neque aliquam vestibulum morbi. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis."
        description.numberOfLines = 0
        description.textColor = .black
         return description
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupViewConstraints()
    }
    
    private func setupViews() {
        view.addSubview(artImageView)
        view.addSubview(imageDescription)
        artImageView.translatesAutoresizingMaskIntoConstraints = false
        imageDescription.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            artImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            artImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            artImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            artImageView.heightAnchor.constraint(equalToConstant: 350),

            imageDescription.topAnchor.constraint(equalTo: artImageView.bottomAnchor, constant: 15),
            imageDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}
