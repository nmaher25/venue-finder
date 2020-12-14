//
//  VenueFinderSearchView.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import UIKit
import MapKit

class VenueFinderSearchView: UIView {
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        
        
        return searchBar
    }()
    
    lazy var venueSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        
        return searchBar
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        
        
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        self.addSubview(locationSearchBar)
        self.addSubview(venueSearchBar)
        self.addSubview(mapView)
        
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        venueSearchBar.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationSearchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            locationSearchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            locationSearchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            venueSearchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            venueSearchBar.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor, constant: 10),
            venueSearchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mapView.topAnchor.constraint(equalTo: venueSearchBar.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
}
