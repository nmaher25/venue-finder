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

// delegate pattern
protocol VenueSearchDelegate: AnyObject {
    func didSelectVenue(_ venue: Venue)
}

class VenueSearchVC: UIViewController {
    let reuseIdentifier = "VenueCell"
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    let venueSearchView = VenueFinderSearchView()
    
    let tableView = UITableView()
    
    weak var delegate: VenueSearchDelegate?
    
    // datasource
    private var venues: [Venue] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var venuePhoto: VenuePhoto? {
        didSet {
            print("DEBUG: venuePhoto set as:\n\(venuePhoto)")
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
        let locationButtonImage = UIImage(named: "location.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let locationBarButtonItem = UIBarButtonItem(image: locationButtonImage, style: .plain, target: self, action: #selector(locationBarButtonItemTapped))
        self.navigationItem.rightBarButtonItem = locationBarButtonItem
        
        locationManager.delegate = self
        
        view.backgroundColor = Styler.Color.darkBlue
        tableView.backgroundColor = .white
        
        navigationItem.title = "Venue Finder"
        navigationController?.navigationBar.tintColor = Styler.Color.darkBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = Styler.Color.darkBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureUI()
        venueSearchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func locationBarButtonItemTapped() {
        configureUserLocationBasedOnPermissions()
        
        if CLLocationManager.locationServicesEnabled() {
            if let currentLocation = currentLocation {
                let venueSearchText = venueSearchView.venueTextField.text ?? ""
                let lat = Double(currentLocation.coordinate.latitude)
                let long = Double(currentLocation.coordinate.longitude)
            
                fetchVenues(atLatitude: lat, atLongitude: long, forQuery: venueSearchText)
            }
        }
    }

    @objc func searchButtonTapped() {
        let locationSearchText = venueSearchView.locationTextField.text ?? ""
        let venueSearchText = venueSearchView.venueTextField.text ?? ""
        
        fetchVenues(nearPlace: locationSearchText, forQuery: venueSearchText)
    }
    
    func configureUI() {
        tableView.rowHeight = 120
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        if venues.count == 0 {
            tableView.showEmptyState()
        } else {
            tableView.hideEmptyState()
        }
        
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VenueTableViewCell
        let venue = venues[indexPath.row]
        cell.venue = venue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let venue = venues[indexPath.row]
        let controller = VenueDetailVC()
        
        self.delegate = controller
        self.delegate?.didSelectVenue(venue)
        navigationController?.pushViewController(controller, animated: true)
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
    
    func toggleEmptyStateView() {
        if venues.count == 0 {
            tableView.showEmptyState()
        } else {
            tableView.hideEmptyState()
        }
    }
}

extension UITableView {
    fileprivate func showEmptyState() {
        let emptyStateView = VenueSearchEmptyState(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        self.backgroundView = emptyStateView
        self.separatorStyle = .none
    }
    
    fileprivate func hideEmptyState() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
