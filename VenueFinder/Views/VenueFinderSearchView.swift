//
//  VenueFinderSearchView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import UIKit

class VenueFinderSearchView: UIView {
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Where are you looking?"
        return searchBar
    }()
    
    lazy var venueSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Whatcha lookin' for?"
        return searchBar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("GO!", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
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
        self.addSubview(locationSearchBar)
        self.addSubview(venueSearchBar)
        self.addSubview(searchButton)
        self.backgroundColor = .systemPink
        
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        venueSearchBar.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationSearchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            locationSearchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            locationSearchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            locationSearchBar.heightAnchor.constraint(equalToConstant: 30),
            
            venueSearchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            venueSearchBar.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor, constant: 10),
            venueSearchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            venueSearchBar.heightAnchor.constraint(equalToConstant: 30),
            
            searchButton.leftAnchor.constraint(equalTo: locationSearchBar.rightAnchor, constant: 10),
            searchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
        ])
    }
    
}
