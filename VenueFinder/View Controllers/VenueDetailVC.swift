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
    
    let venueDetailContainer = VenueDetailContainerView()
    
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
    }
    
    func configureUI() {
        view.addSubview(venueDetailContainer)
        venueDetailContainer.translatesAutoresizingMaskIntoConstraints = false
        
        venueDetailContainer.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        venueDetailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        venueDetailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        venueDetailContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
}
