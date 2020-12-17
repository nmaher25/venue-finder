//
//  VenueDetailContainerView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/16/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import UIKit

class VenueDetailContainerView: UIScrollView {
    
    lazy var venueAddressTitle: UILabel = {
        let label = UILabel()
        
        let attributedTitle = NSMutableAttributedString(string: "Address", attributes: [
            NSAttributedString.Key.font: Styler.Font.titleBoldFont,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        label.attributedText = attributedTitle
        
        return label
    }()
    
    lazy var venuePhoneTitle: UILabel = {
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: "Phone", attributes: [
            NSAttributedString.Key.font: Styler.Font.titleBoldFont,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        label.attributedText = attributedTitle
        return label
    }()
    
    lazy var venueWebsiteTitle: UILabel = {
        let label = UILabel()
        
        let attributedTitle = NSMutableAttributedString(string: "Website", attributes: [
            NSAttributedString.Key.font: Styler.Font.titleBoldFont,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        label.attributedText = attributedTitle
        
        return label
    }()
    
    lazy var venueAddressBody: UILabel = {
        let label = UILabel()
        label.font = Styler.Font.bodyFont
        label.numberOfLines = 0
        label.text = "123 Main st. \nCollingswood, NJ"
        return label
    }()
    
    lazy var venuePhoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("(609) 332-7595", for: .normal)
        return button
    }()
    
    lazy var venueWebsiteButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("www.google.com", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let addressStack = UIStackView(arrangedSubviews: [venueAddressTitle, venueAddressBody])
        addressStack.axis = .vertical
        addressStack.spacing = 5
        
        let phoneStack = UIStackView(arrangedSubviews: [venuePhoneTitle, venuePhoneButton])
        phoneStack.axis = .vertical
        phoneStack.spacing = 5
        
        let websiteStack = UIStackView(arrangedSubviews: [venueWebsiteTitle, venueWebsiteButton])
        websiteStack.axis = .vertical
        websiteStack.spacing = 5
        
        let fullInfoStack = UIStackView(arrangedSubviews: [addressStack, phoneStack, websiteStack])
        fullInfoStack.axis = .vertical
        fullInfoStack.spacing = 10
        
        addSubview(fullInfoStack)
        fullInfoStack.translatesAutoresizingMaskIntoConstraints = false
        fullInfoStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fullInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fullInfoStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
