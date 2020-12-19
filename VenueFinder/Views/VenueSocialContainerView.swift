//
//  VenueSocialContainerView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/16/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit

class VenueSocialContainerView: UIScrollView {
    
    lazy var venueSocialTitle: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Socials"
        
        return label
    }()
    
    lazy var twitterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "twitter")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Twitter", for: .normal)
        return button
    }()
    
    lazy var instagramImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "instagram")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    lazy var instagramButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Instagram", for: .normal)
        return button
    }()
    
    lazy var facebookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "facebook")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Facebook", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(venueSocialTitle)
        venueSocialTitle.translatesAutoresizingMaskIntoConstraints = false
        
        venueSocialTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        venueSocialTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        let twitterStack = UIStackView(arrangedSubviews: [twitterImage, twitterButton])
        twitterStack.axis = .horizontal
        twitterStack.spacing = 5
        
        addSubview(twitterStack)
        twitterStack.translatesAutoresizingMaskIntoConstraints = false
        twitterStack.topAnchor.constraint(equalTo: venueSocialTitle.bottomAnchor, constant: 10).isActive = true
        twitterStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        let instagramStack = UIStackView(arrangedSubviews: [instagramImage, instagramButton])
        instagramStack.axis = .horizontal
        instagramStack.spacing = 5
        
        addSubview(instagramStack)
        instagramStack.translatesAutoresizingMaskIntoConstraints = false
        instagramStack.topAnchor.constraint(equalTo: twitterStack.bottomAnchor, constant: 8).isActive = true
        instagramStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        let facebookStack = UIStackView(arrangedSubviews: [facebookImage, facebookButton])
        facebookStack.axis = .horizontal
        facebookStack.spacing = 5
        
        addSubview(facebookStack)
        facebookStack.translatesAutoresizingMaskIntoConstraints = false
        facebookStack.topAnchor.constraint(equalTo: instagramStack.bottomAnchor, constant: 8).isActive = true
        facebookStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        /*
        let fullSocialStack = UIStackView(arrangedSubviews: [venueSocialTitle, twitterStack, instagramStack, facebookStack])
        fullSocialStack.axis = .vertical
        fullSocialStack.spacing = 10
        
        addSubview(fullSocialStack)
        fullSocialStack.translatesAutoresizingMaskIntoConstraints = false
        fullSocialStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullSocialStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fullSocialStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fullSocialStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true*/
    }
}
