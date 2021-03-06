//
//  VenueDetailContainerView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/16/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import UIKit

class VenueDetailContainerView: UIScrollView {
    
    // MARK: - Properties
    lazy var venueAddressTitle: UILabel = {
        let label = UILabel()
        
        label.font = Styler.Font.mediumBold
        label.text = "Address"
        
        return label
    }()
    
    lazy var venuePhoneTitle: UILabel = {
        let label = UILabel()
        label.font = Styler.Font.mediumBold
        label.text = "Phone"
        return label
    }()
    
    lazy var venueWebsiteTitle: UILabel = {
        let label = UILabel()
        
        label.font = Styler.Font.mediumBold
        label.text = "Website"
        
        return label
    }()
    
    lazy var venueStreetAddressBody: UILabel = {
        let label = UILabel()
        
        label.font = Styler.Font.smallNormal
        label.textColor = Styler.Color.textLight
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var venueCityStateBody: UILabel = {
        let label = UILabel()
        
        label.font = Styler.Font.smallNormal
        label.textColor = Styler.Color.textLight
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var venuePhoneButton: UIButton = {
        let button = UIButton(type: .system)

        return button
    }()
    
    lazy var venueWebsiteButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = Styler.Color.lightPinkDetail.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        let addressStack = UIStackView(arrangedSubviews: [venueAddressTitle, venueStreetAddressBody, venueCityStateBody])
        addressStack.axis = .vertical
        addressStack.spacing = Styler.Margin.small
        
        addSubview(addressStack)
        addressStack.translatesAutoresizingMaskIntoConstraints = false
        addressStack.topAnchor.constraint(equalTo: topAnchor, constant: Styler.Margin.medium).isActive = true
        addressStack.leftAnchor.constraint(equalTo: leftAnchor, constant: Styler.Margin.medium).isActive = true
        
        
        let phoneStack = UIStackView(arrangedSubviews: [venuePhoneTitle, venuePhoneButton])
        phoneStack.axis = .vertical
        phoneStack.spacing = 2
        
        addSubview(phoneStack)
        phoneStack.translatesAutoresizingMaskIntoConstraints = false
        phoneStack.topAnchor.constraint(equalTo: addressStack.bottomAnchor, constant: Styler.Margin.medium).isActive = true
        phoneStack.leftAnchor.constraint(equalTo: leftAnchor, constant: Styler.Margin.medium).isActive = true
        
        let websiteStack = UIStackView(arrangedSubviews: [venueWebsiteTitle, venueWebsiteButton])
        websiteStack.axis = .vertical
        websiteStack.spacing = 2
        
        addSubview(websiteStack)
        websiteStack.translatesAutoresizingMaskIntoConstraints = false
        websiteStack.topAnchor.constraint(equalTo: phoneStack.bottomAnchor, constant: Styler.Margin.medium).isActive = true
        websiteStack.leftAnchor.constraint(equalTo: leftAnchor, constant: Styler.Margin.medium).isActive = true
        websiteStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -Styler.Margin.medium).isActive = true
    }
}
