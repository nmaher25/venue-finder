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
    
    // MARK: - Properties
    let reuseIdentifier = "VenueCell"
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? 
    
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
    
    // MARK: - Lifecycle
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
        
        self.venueSearchView.locationTextField.delegate = self
        self.venueSearchView.venueTextField.delegate = self
        
        locationManager.delegate = self
        
        view.backgroundColor = Styler.Color.pinkMain
        tableView.backgroundColor = .white
        
        navigationItem.title = "Venue Finder"
        navigationController?.navigationBar.tintColor = Styler.Color.pinkMain
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = Styler.Color.pinkMain
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.delegate = self
        
        configureUI()
        configureUserLocationBasedOnPermissions()
        venueSearchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc func locationBarButtonItemTapped() {
        configureUserLocationBasedOnPermissions()
        if let currentLocation = currentLocation {
            if CLLocationManager.locationServicesEnabled() {
                let venueSearchText = venueSearchView.venueTextField.text ?? ""
                    venueSearchView.locationTextField.text = "My Location"
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
    
    // MARK: - Helpers
    func configureUI() {
        tableView.rowHeight = 120
        view.addSubview(venueSearchView)
        view.addSubview(tableView)
        venueSearchView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        venueSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        venueSearchView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        venueSearchView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        venueSearchView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            
        tableView.topAnchor.constraint(equalTo: venueSearchView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureUserLocationBasedOnPermissions() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
            
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            self.presentLocationAccessNeededAlert()
            break
            
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
    
    func presentAlertForSearchError(forVenueError venueError: ErrorResponse.VenueError) {
        let alertCopy: String
        switch venueError.code {
        case 403, 429: //hourly/daily rate limit exceeded
            alertCopy = "Daily rate limit reached for this API - Hire me to see more!"
        case 400: //geocode errors, etc
            alertCopy = "Your location could not found, or no locations with your query were found. Try searching again!"
        default:
            alertCopy = "Sorry, there was an issue with your request. Please try again in a few seconds."
        }
        let alert = UIAlertController(title: "Error:\n\(venueError.errorDetail)", message: "\(alertCopy)", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate & DataSource
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

// MARK: - CLLocationManagerDelegate
extension VenueSearchVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.first
    }
}

// MARK: - API
extension VenueSearchVC {
    func fetchVenues(atLatitude lat: Double, atLongitude long: Double, forQuery query: String) {
        FoursquareService.shared.fetchVenues(atLatitude: lat, atLongitude: long, forQuery: query, completion: { (venues) in
            guard let venues = venues else { return }
            self.venues = venues
        }) { (error) in
            guard let error = error else { return }
            DispatchQueue.main.async {
                self.presentAlertForSearchError(forVenueError: error.meta)
            }
        }
    }
    
    func fetchVenues(nearPlace place: String, forQuery query: String) {
        FoursquareService.shared.fetchVenues(nearPlace: place, forQuery: query, completion: { (venues) in
            guard let venues = venues else { return }
            self.venues = venues
        }) { (error) in
            guard let error = error else { return }
            DispatchQueue.main.async {
                self.presentAlertForSearchError(forVenueError: error.meta)
            }
        }
    }
}

extension VenueSearchVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return DetailFadePushAnimator()
        case .pop:
            return DetailFadePopAnimator()
        default:
            return nil
        }
    }
}

extension VenueSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension UITableView {
    fileprivate func showEmptyState() {
        DispatchQueue.main.async {
            let emptyStateView = VenueSearchEmptyState(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
            self.backgroundView = emptyStateView
            self.separatorStyle = .none
        }
    }
    
    fileprivate func hideEmptyState() {
        DispatchQueue.main.async {
            self.backgroundView = nil
            self.separatorStyle = .singleLine
        }
    }
}
