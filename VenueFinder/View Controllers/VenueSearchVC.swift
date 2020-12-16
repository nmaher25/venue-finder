//
//  ViewController.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class VenueSearchVC: UIViewController {
    let reuseIdentifier = "VenueCell"
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    let venueSearchView = VenueFinderSearchView()
    
    let tableView = UITableView()
    
    // datasource
    private var venues: [Venue] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VenueTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationBarButtonItem = UIBarButtonItem(image: UIImage(named: "location.fill"), style: .plain, target: self, action: #selector(locationBarButtonItemTapped))
        self.navigationItem.rightBarButtonItem = locationBarButtonItem
        
        locationManager.delegate = self
        
        view.backgroundColor = .green
        tableView.backgroundColor = .orange
        configureUI()
        venueSearchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func locationBarButtonItemTapped() {
        configureUserLocationBasedOnPermissions()
        
        if CLLocationManager.locationServicesEnabled() {
            if let currentLocation = currentLocation {
                let venueSearchText = venueSearchView.venueSearchBar.text ?? ""
                let lat = Double(currentLocation.coordinate.latitude)
                let long = Double(currentLocation.coordinate.longitude)
            
                fetchVenues(atLatitude: lat, atLongitude: long, forQuery: venueSearchText)
            }
        }
    }

    @objc func searchButtonTapped() {
        let locationSearchText = venueSearchView.locationSearchBar.text ?? ""
        let venueSearchText = venueSearchView.venueSearchBar.text ?? ""
        
        fetchVenues(nearPlace: locationSearchText, forQuery: venueSearchText)
    }
    
    func configureUI() {
        navigationItem.title = "Venue Finder"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        view.addSubview(venueSearchView)
        view.addSubview(tableView)
        venueSearchView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            venueSearchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            venueSearchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            venueSearchView.heightAnchor.constraint(equalToConstant: 90),
            
            tableView.topAnchor.constraint(equalTo: venueSearchView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureUserLocationBasedOnPermissions() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
            
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            self.presentLocationAccessNeededAlert()
            
        @unknown default:
            print("whoops")
        }
    }
    
    func presentLocationAccessNeededAlert() {
        guard let settingsAppUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        let alert = UIAlertController(title: "Need Location Access",
                                      message: "Location Access is required to find venues near your location.",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Go to Settings",
                                      style: .cancel,
                                      handler: { (alert) -> Void in
                                        UIApplication.shared.open(settingsAppUrl,
                                                                  options: [:],
                                                                  completionHandler: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

// Tableview Delegate & Datasource
extension VenueSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VenueTableViewCell
        let venue = venues[indexPath.row]
        cell.venue = venue
        
        return cell
    }
    
    
}

extension VenueSearchVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
}

// Helpers
extension VenueSearchVC {
    func fetchVenues(atLatitude lat: Double, atLongitude long: Double, forQuery query: String) {
        
        FoursquareService.shared.fetchVenues(atLatitude: lat, atLongitude: long, forQuery: query) { (venues) in
            guard let venues = venues else { return }
            self.venues = venues
        }
    }
    
    func fetchVenues(nearPlace place: String, forQuery query: String) {
        FoursquareService.shared.fetchVenues(nearPlace: place, forQuery: query) { (venues) in
            guard let venues = venues else { return }
            self.venues = venues
        }
    }
}
