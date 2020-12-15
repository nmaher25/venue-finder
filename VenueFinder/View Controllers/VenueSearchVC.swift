//
//  ViewController.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class VenueSearchVC: UIViewController {

    let venueSearchView = VenueFinderSearchView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        configureUI()
        venueSearchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }

    @objc func searchButtonTapped() {
        let locationSearchText = venueSearchView.locationSearchBar.text ?? ""
        let venueSearchText = venueSearchView.venueSearchBar.text ?? ""
        print("Search button tapped with location \(locationSearchText) and venue \(venueSearchText)")
    }
    
    func configureUI() {
        navigationItem.title = "Venue Finder"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        view.addSubview(venueSearchView)
        venueSearchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            venueSearchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            venueSearchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            venueSearchView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }

}



