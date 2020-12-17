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
    private var venue: Venue? {
        didSet {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    let venueDetailImage = UIImageView()
    let venueDetailContainer = VenueDetailContainerView()
    let venueSocialContainer = VenueSocialContainerView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        
        if let venue = venue {
            navigationItem.title = venue.name
            
            if let formattedAddress = venue.location.formattedAddress {
                venueDetailContainer.venueAddressBody.text = "\(formattedAddress[0])\n\(formattedAddress[1])\n\(formattedAddress[2])"
            } else {
                venueDetailContainer.venueAddressBody.text = "No address found"
            }
            
            if let formattedPhoneNumber = venue.contact?.formattedPhone {
                venueDetailContainer.venuePhoneButton.setTitle(formattedPhoneNumber, for: .normal)
            } else {
                venueDetailContainer.venuePhoneButton.isEnabled = false
                venueDetailContainer.venuePhoneButton.setTitle("No phone number found", for: .disabled)
            }
            
            if let website = venue.url {
                venueDetailContainer.venueWebsiteButton.setTitle(website, for: .normal)
            } else {
                venueDetailContainer.venueWebsiteButton.isEnabled = false
                venueDetailContainer.venueWebsiteButton.setTitle("No website found", for: .disabled)
            }
            
            if let twitter = venue.contact?.twitter {
                venueSocialContainer.twitterButton.setTitle("@\(twitter)", for: .normal)
            } else {
                venueSocialContainer.twitterButton.isEnabled = false
                venueSocialContainer.twitterButton.setTitle("N/A", for: .disabled)
            }
            
            if let instagram = venue.contact?.facebook {
                venueSocialContainer.instagramButton.setTitle("@\(instagram)", for: .normal)
            } else {
                venueSocialContainer.instagramButton.isEnabled = false
                venueSocialContainer.instagramButton.setTitle("N/A", for: .disabled)
            }
            
            if let facebookUsername = venue.contact?.facebookUsername, let facebookId = venue.contact?.facebook {
                venueSocialContainer.facebookButton.setTitle("/\(facebookUsername)", for: .normal)
            } else {
                venueSocialContainer.facebookButton.isEnabled = false
                venueSocialContainer.facebookButton.setTitle("N/A", for: .disabled)
            }
        }
    }
}

extension VenueDetailVC: VenueSearchDelegate {
    func didSelectVenue(_ venue: Venue) {
        print("DEBUG: didSelectVenue called from VenueDetailVC \nnetwork against the venue details endpoint using the passed in venue's ID")
        print("Venue id passed in is \(venue.id)")
        fetchVenueDetails(forVenue: venue)
    }
    
    
}

extension VenueDetailVC {
    func fetchVenueDetails(forVenue venue: Venue) {
        FoursquareService.shared.fetchVenueDetails(forVenueId: venue.id) { (venue) in
            self.venue = venue
        }
    }
}
