//
//  VenueDetailVC.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/16/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class VenueDetailVC: UIViewController {
    private var venue: Venue? {
        didSet {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    //private var venuePhoto: VenuePhoto?
    
    let venueDetailImage = UIImageView()
    let venueDetailContainer = VenueDetailContainerView()
    let venueSocialContainer = VenueSocialContainerView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        venueDetailContainer.venuePhoneButton.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        venueDetailContainer.venueWebsiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
        
        venueSocialContainer.twitterButton.addTarget(self, action: #selector(twitterButtonTapped), for: .touchUpInside)
        venueSocialContainer.instagramButton.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)
        venueSocialContainer.facebookButton.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Styler.Color.pinkMain
        venueDetailImage.backgroundColor = .lightGray
        venueDetailImage.contentMode = .scaleAspectFill
        venueDetailImage.clipsToBounds = true
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = Styler.Color.pinkMain
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        /***** for use when over api limit *****/
        /*let jsonDecoder = JSONDecoder()
        if let data = dummyVenueDetailData {
            let venue = try! jsonDecoder.decode(ResponseDetail.self, from: data)
            self.venue = venue.response.venue
        } else {
            print("bad")
        }*/
    }
    
    // MARK: - Selectors
    @objc func phoneButtonTapped() {
        if let venue = venue, let venueContact = venue.contact, let venuePhone = venueContact.phone {
            if let phoneUrl = URL(string: "tel://\(venuePhone)") {

                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneUrl)) {
                    application.open(phoneUrl, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    @objc func websiteButtonTapped() {
        if let venue = venue, let venueUrl = venue.url {
            if let url = URL(string: venueUrl) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let webview = SFSafariViewController(url: url, configuration: config)
                present(webview, animated: true)
            }
        }
    }
    
    @objc func twitterButtonTapped() {
        if let venue = venue, let venueContact = venue.contact, let venueTwitter = venueContact.twitter {
            if let url = URL(string: "https://www.twitter.com/\(venueTwitter)") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let webview = SFSafariViewController(url: url, configuration: config)
                present(webview, animated: true)
            }
        }
    }
    
    @objc func instagramButtonTapped() {
        if let venue = venue, let venueContact = venue.contact, let venueInstagram = venueContact.instagram {
            if let url = URL(string: "https://www.instagram.com/\(venueInstagram)") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let webview = SFSafariViewController(url: url, configuration: config)
                present(webview, animated: true)
            }
        }
    }
    
    @objc func facebookButtonTapped() {
        if let venue = venue, let venueContact = venue.contact, let venueFacebook = venueContact.facebook {
            if let url = URL(string: "https://www.facebook.com/\(venueFacebook)") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let webview = SFSafariViewController(url: url, configuration: config)
                present(webview, animated: true)
            }
        }
    }
    
    func presentAlertForDetailError(forVenueError venueError: ErrorResponse.VenueError) {
        let alertCopy: String
        switch venueError.code {
        case 403, 429: //hourly/daily rate limit exceeded
            alertCopy = "Daily rate limit reached for this API - hire me to see more!"
        case 400:
            alertCopy = "Sorry, we could not retrieve any details for this venue."
        default:
            alertCopy = "Sorry, there was an issue with your request. Please try again in a few seconds."
        }
        let alert = UIAlertController(title: "Error:\n\(venueError.errorDetail)", message: "\(alertCopy)", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: { (alert) -> Void in
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func configureUI() {
        view.addSubview(venueDetailContainer)
        venueDetailContainer.translatesAutoresizingMaskIntoConstraints = false
        
        venueDetailContainer.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        venueDetailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        venueDetailContainer.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        venueDetailContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(venueSocialContainer)
        venueSocialContainer.translatesAutoresizingMaskIntoConstraints = false
        
        venueSocialContainer.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        venueSocialContainer.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        venueSocialContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        venueSocialContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(venueDetailImage)
        venueDetailImage.translatesAutoresizingMaskIntoConstraints = false
        venueDetailImage.clipsToBounds = true
        venueDetailImage.layer.cornerRadius = 10
        venueDetailImage.layer.borderColor = Styler.Color.lightPinkDetail.cgColor
        venueDetailImage.layer.borderWidth = 2
        venueDetailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        venueDetailImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        venueDetailImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        venueDetailImage.bottomAnchor.constraint(equalTo: venueDetailContainer.topAnchor, constant: -10).isActive = true
        
        if let venue = venue {
            navigationItem.title = venue.name
            if let photoUrl = FoursquareService.shared.imageUrlCache[venue.id] {
                venueDetailImage.sd_setImage(with: photoUrl)
            } else {
                venueDetailImage.image = UIImage(named: "nosign")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            }
            
            
            if let address = venue.location.address, let city = venue.location.city, let state = venue.location.state, let zipcode = venue.location.postalCode {
                venueDetailContainer.venueStreetAddressBody.text = address
                venueDetailContainer.venueCityStateBody.text = "\(city), \(state) \(zipcode)"
            } else {
                venueDetailContainer.venueStreetAddressBody.text = "No address found"
                venueDetailContainer.venueStreetAddressBody.textColor = Styler.Color.errorRed
                venueDetailContainer.venueCityStateBody.isHidden = true
            }
            
            if let formattedPhoneNumber = venue.contact?.formattedPhone {
                venueDetailContainer.venuePhoneButton.setTitle(formattedPhoneNumber, for: .normal)
            } else {
                venueDetailContainer.venuePhoneButton.isEnabled = false
                venueDetailContainer.venuePhoneButton.setTitle("No phone number found", for: .disabled)
            }
            
            if let website = venue.url {
                venueDetailContainer.venueWebsiteButton.setTitle(venue.name, for: .normal)
            } else {
                venueDetailContainer.venueWebsiteButton.isEnabled = false
                venueDetailContainer.venueWebsiteButton.setTitle("No website found", for: .disabled)
            }
            
            if let twitter = venue.contact?.twitter {
                venueSocialContainer.twitterButton.setTitle("@\(twitter)", for: .normal)
            } else {
                venueSocialContainer.twitterButton.isEnabled = false
                venueSocialContainer.twitterButton.setTitle("n/a", for: .disabled)
            }
            
            if let instagram = venue.contact?.instagram {
                venueSocialContainer.instagramButton.setTitle("@\(instagram)", for: .normal)
            } else {
                venueSocialContainer.instagramButton.isEnabled = false
                venueSocialContainer.instagramButton.setTitle("n/a", for: .disabled)
            }
            
            if let facebookUsername = venue.contact?.facebookUsername, let facebookId = venue.contact?.facebook {
                venueSocialContainer.facebookButton.setTitle("/\(facebookUsername)", for: .normal)
            } else {
                venueSocialContainer.facebookButton.isEnabled = false
                venueSocialContainer.facebookButton.setTitle("n/a", for: .disabled)
            }
        }
    }
}

extension VenueDetailVC: VenueSearchDelegate {
    func didSelectVenue(_ venue: Venue) {
        fetchVenueDetails(forVenue: venue)
    }
    
    
}

extension VenueDetailVC {
    func fetchVenueDetails(forVenue venue: Venue) {
        FoursquareService.shared.fetchVenueDetails(forVenueId: venue.id, completion: { (venue) in
            self.venue = venue
        }) { (detailError) in
            guard let detailError = detailError else { return }
            DispatchQueue.main.async {
                self.presentAlertForDetailError(forVenueError: detailError.meta)
            }
        }
        
        /*
        FoursquareService.shared.fetchVenueDetails(forVenueId: venue.id) { (venue) in
            self.venue = venue
        }*/
    }
}
