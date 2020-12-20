//
//  VenueFinderSearchView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import UIKit

class VenueFinderSearchView: UIView {
    
    // MARK: - Properties
    lazy var locationTextFieldView: UIView = {
        let view = Utilities.inputContainerView(textField: locationTextField)
        
        return view
    }()
    
    lazy var venueTextFieldView: UIView = {
        let view = Utilities.inputContainerView(textField: venueTextField)
        
        return view
    }()
    
    let locationTextField: UITextField = {
        let textField = Utilities.textField(withPlaceholder: "Where are you looking?")
        
        return textField
    }()
    
    let venueTextField: UITextField = {
        let textField = Utilities.textField(withPlaceholder: "Whatcha lookin' for?")
        
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        
        let buttonAttributedString = NSAttributedString(string: "GO!", attributes: [
            NSAttributedString.Key.foregroundColor: Styler.Color.textNormal,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)
        ])
        button.setAttributedTitle(buttonAttributedString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.layer.cornerRadius = 70 / 2
        button.layer.borderWidth = 2
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderColor = Styler.Color.lightPinkDetail.cgColor
        
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        addSubview(locationTextFieldView)
        addSubview(venueTextFieldView)
        addSubview(searchButton)
        backgroundColor = Styler.Color.pinkMain
        
        locationTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        venueTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        locationTextFieldView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Styler.Margin.medium).isActive = true
        locationTextFieldView.topAnchor.constraint(equalTo: self.topAnchor, constant: Styler.Margin.medium).isActive = true
        locationTextFieldView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true
        locationTextFieldView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
        venueTextFieldView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Styler.Margin.medium).isActive = true
        venueTextFieldView.topAnchor.constraint(equalTo: locationTextFieldView.bottomAnchor, constant: Styler.Margin.medium).isActive = true
        venueTextFieldView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true
        venueTextFieldView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
        searchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Styler.Margin.medium).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Styler.Margin.medium).isActive = true
    }
    
}
