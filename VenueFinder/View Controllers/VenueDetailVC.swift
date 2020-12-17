//
//  VenueDetailVC.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/16/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit

class VenueDetailVC: UIViewController {
    private var venue: Venue?
    
    let venueDetailImage = UIImageView()
    let venueDetailContainer = VenueDetailContainerView()
    let venueSocialContainer = VenueSocialContainerView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        venueDetailImage.backgroundColor = .lightGray
    }
    
    func configureUI() {
        navigationItem.title = "John's Pizza Place"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(venueDetailContainer)
        venueDetailContainer.translatesAutoresizingMaskIntoConstraints = false
        
        venueDetailContainer.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        venueDetailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        venueDetailContainer.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
        venueDetailContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(venueSocialContainer)
        venueSocialContainer.translatesAutoresizingMaskIntoConstraints = false
        
        venueSocialContainer.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        venueSocialContainer.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2).isActive = true
        venueSocialContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        venueSocialContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(venueDetailImage)
        venueDetailImage.translatesAutoresizingMaskIntoConstraints = false
        
        venueDetailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        venueDetailImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        venueDetailImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        venueDetailImage.bottomAnchor.constraint(equalTo: venueDetailContainer.topAnchor, constant: -10).isActive = true
    }
}

extension VenueDetailVC: VenueSearchDelegate {
    func didSelectVenue(_ venue: Venue) {
        print("DEBUG: didSelectVenue called from VenueDetailVC \nnetwork against the venue details endpoint using the passed in venue's ID")
        print("Venue id passed in is \(venue.id)")
    }
    
    
}
