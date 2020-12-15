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
        
        label.text = "Venue Name"
        
        return label
    }()
    
    private let venueAddressLabel: UILabel = {
        let label = UILabel()
        
        label.text = "123 Main St."
        
        return label
    }()
    
    private let venueDistanceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "XX mi"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        addSubview(venueImageView)
        venueImageView.translatesAutoresizingMaskIntoConstraints = false
        venueImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        venueImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let verticalStack = UIStackView(arrangedSubviews: [venueNameLabel, venueAddressLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        
        addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.leftAnchor.constraint(equalTo: venueImageView.rightAnchor, constant: 10).isActive = true
        verticalStack.centerYAnchor.constraint(equalTo: venueImageView.centerYAnchor).isActive = true
        
        addSubview(venueDistanceLabel)
        venueDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        venueDistanceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        venueDistanceLabel.centerYAnchor.constraint(equalTo: verticalStack.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure() {
        
    }
}
