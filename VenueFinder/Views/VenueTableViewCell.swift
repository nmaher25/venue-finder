//
//  VenueTableViewCell.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit

class VenueTableViewCell: UITableViewCell {
    var venue: Venue? {
        didSet {
            configure()
        }
    }
    
    private let venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    private let venueNameLabel: UILabel = {
        let label = UILabel()
        
        //label.text = "Venue Name"
        
        return label
    }()
    
    private let venueAddressLabel: UILabel = {
        let label = UILabel()
        
        //label.text = "123 Main St."
        
        return label
    }()
    
    private let venueDistanceLabel: UILabel = {
        let label = UILabel()
        
        //label.text = "XX mi"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        DispatchQueue.main.async {
            self.addSubview(self.venueImageView)
            self.venueImageView.translatesAutoresizingMaskIntoConstraints = false
            self.venueImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            self.venueImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            let verticalStack = UIStackView(arrangedSubviews: [self.venueNameLabel, self.venueAddressLabel])
            verticalStack.axis = .vertical
            verticalStack.spacing = 5
            
            self.addSubview(verticalStack)
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            verticalStack.leftAnchor.constraint(equalTo: self.venueImageView.rightAnchor, constant: 10).isActive = true
            verticalStack.centerYAnchor.constraint(equalTo: self.venueImageView.centerYAnchor).isActive = true
            
            self.addSubview(self.venueDistanceLabel)
            self.venueDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
            self.venueDistanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
            self.venueDistanceLabel.centerYAnchor.constraint(equalTo: verticalStack.centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure() {
        guard let venue = self.venue else { return }
        DispatchQueue.main.async {
            self.venueNameLabel.text = venue.name
            self.venueAddressLabel.text = venue.location.address ?? "Could not retrieve address"
            if let distance = venue.location.distance {
                self.venueDistanceLabel.isHidden = false
                self.venueDistanceLabel.text = "\(distance)"
            } else {
                self.venueDistanceLabel.isHidden = true
            
            }
        }
    }
}
