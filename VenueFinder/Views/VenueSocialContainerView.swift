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
        
        let attributedTitle = NSMutableAttributedString(string: "Socials", attributes: [
            NSAttributedString.Key.font: Styler.Font.titleBoldFont,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        label.attributedText = attributedTitle
        
        return label
    }()
    
    lazy var twitterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Twitter", for: .normal)
        return button
    }()
    
    lazy var instagramImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setTitle("Instagram", for: .normal)
        return button
    }()
    
    lazy var facebookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook", for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let twitterStack = UIStackView(arrangedSubviews: [twitterImage, twitterButton])
        twitterStack.axis = .horizontal
        twitterStack.spacing = 5
        
        let instagramStack = UIStackView(arrangedSubviews: [instagramImage, instagramButton])
        instagramStack.axis = .horizontal
        instagramStack.spacing = 5
        
        let facebookStack = UIStackView(arrangedSubviews: [facebookImage, facebookButton])
        facebookStack.axis = .horizontal
        facebookStack.spacing = 5
        
        let fullSocialStack = UIStackView(arrangedSubviews: [venueSocialTitle, twitterStack, instagramStack, facebookStack])
        fullSocialStack.axis = .vertical
        fullSocialStack.spacing = 10
        
        addSubview(fullSocialStack)
        fullSocialStack.translatesAutoresizingMaskIntoConstraints = false
        fullSocialStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullSocialStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fullSocialStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fullSocialStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
