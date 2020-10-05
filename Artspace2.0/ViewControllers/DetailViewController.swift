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
    lazy var TitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.sizeToFit()
        return label
    }()
    lazy var DescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.sizeToFit()
        return label
    }()
    lazy var ARfeatureButton: UIButton = {
        let label = UIButton()
        label.backgroundColor = .systemBlue
        label.sizeToFit()
        return label
    }()
    
    func addSubView() {
        self.view.addSubview(ArtImageView)
        self.view.addSubview(TitleLabel)
        self.view.addSubview(DescriptionLabel)
        self.view.addSubview(ARfeatureButton)
    }
    func Constraints() {
        setArtImageViewConstraints()
        setArtNameConstraints()
        setARButtonConstraints()
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        Constraints()
    }
    //MARK: CONSTRAINTS
    private func setArtImageViewConstraints() {
    ArtImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    ArtImageView.topAnchor.constraint(equalTo: self.TitleLabel.bottomAnchor, constant: 50),
    ArtImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ArtImageView.widthAnchor.constraint(equalToConstant: 350),
    ArtImageView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    private func setArtNameConstraints() {
    TitleLabel.translatesAutoresizingMaskIntoConstraints = false
     NSLayoutConstraint.activate([
    TitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
    TitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    TitleLabel.widthAnchor.constraint(equalToConstant: 350),
    TitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setARButtonConstraints() {
    ARfeatureButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    ARfeatureButton.bottomAnchor.constraint(equalTo: self.ArtImageView.bottomAnchor,constant: 200),
    ARfeatureButton.centerXAnchor.constraint(equalTo: self.ArtImageView.centerXAnchor),
    ARfeatureButton.widthAnchor.constraint(equalToConstant: 100),
    ARfeatureButton.heightAnchor.constraint(equalToConstant: 100)
         ])
     }
}
