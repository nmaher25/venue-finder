//
//  VenueFinderSearchView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import UIKit

class VenueFinderSearchView: UIView {
    
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
    
    
    
    /*
    lazy var locationTextFieldView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var venueTextFieldView: UIView = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Whatcha lookin' for?"
        return searchBar
    }()*/
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("GO!", for: .normal)
        button.setTitleColor(Styler.Color.twitterBlue, for: .normal)
        button.layer.borderWidth = 1
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        self.addSubview(locationTextFieldView)
        self.addSubview(venueTextFieldView)
        self.addSubview(searchButton)
        self.backgroundColor = .systemPink
        
        locationTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        venueTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationTextFieldView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            locationTextFieldView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            locationTextFieldView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            locationTextFieldView.heightAnchor.constraint(equalToConstant: 30),
            
            venueTextFieldView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            venueTextFieldView.topAnchor.constraint(equalTo: locationTextFieldView.bottomAnchor, constant: 10),
            venueTextFieldView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            venueTextFieldView.heightAnchor.constraint(equalToConstant: 30),
            
            searchButton.leftAnchor.constraint(equalTo: locationTextFieldView.rightAnchor, constant: 10),
            searchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
        ])
    }
    
}
