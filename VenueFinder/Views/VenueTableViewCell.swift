//
//  VenueTableViewCell.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/14/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class VenueTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var venue: Venue? {
        didSet {
            configure()
        }
    }
    
    var venuePhoto: VenuePhoto? {
        didSet {
            configurePhoto()
        }
    }
    
    private let venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.layer.cornerRadius = 70 / 2
        return imageView
    }()
    
    private let venueNameLabel: UILabel = {
        let label = UILabel()
        label.font = Styler.Font.largeBold
        label.textColor = Styler.Color.textNormal
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let venueAddressLabel: UILabel = {
        let label = UILabel()
        label.font = Styler.Font.mediumNormal
        label.textColor = Styler.Color.textLight
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let venueDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = Styler.Font.smallNormal
        label.textColor = Styler.Color.textLight
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        DispatchQueue.main.async {
            self.addSubview(self.venueImageView)
            self.venueImageView.translatesAutoresizingMaskIntoConstraints = false
            self.venueImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Styler.Margin.medium).isActive = true
            self.venueImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            let verticalStack = UIStackView(arrangedSubviews: [self.venueNameLabel, self.venueAddressLabel])
            verticalStack.axis = .vertical
            verticalStack.spacing = Styler.Margin.small
            
            self.addSubview(verticalStack)
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            verticalStack.leftAnchor.constraint(equalTo: self.venueImageView.rightAnchor, constant: Styler.Margin.medium).isActive = true
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: Styler.Margin.medium).isActive = true
            verticalStack.widthAnchor.constraint(equalToConstant: self.frame.width*0.6).isActive = true
            
            self.addSubview(self.venueDistanceLabel)
            self.venueDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
            self.venueDistanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35).isActive = true
            self.venueDistanceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.venueAddressLabel.text = nil
        self.venueAddressLabel.textColor = Styler.Color.textLight
        self.venueAddressLabel.font = Styler.Font.mediumNormal
        self.venueImageView.image = nil
    }
    
    // MARK: - Helpers
    func configure() {
        guard let venue = self.venue else { return }
        fetchVenuePhotos(forVenueId: venue.id, withLimit: 1, withOffset: 0)
        
        DispatchQueue.main.async {
            self.venueNameLabel.text = venue.name
            if let address = venue.location.address, let city = venue.location.city, let state = venue.location.state {
                self.venueAddressLabel.text = "\(address)\n\(city), \(state)"
            } else {
                self.venueAddressLabel.text = "Could not find address"
                self.venueAddressLabel.font = Styler.Font.smallNormal
                self.venueAddressLabel.textColor = Styler.Color.errorRed
            }
            if let distance = venue.location.distance {
                self.venueDistanceLabel.isHidden = false
                self.venueDistanceLabel.text = self.configureDistanceText(forDistance: distance)
            } else {
                self.venueDistanceLabel.isHidden = true
            }
        }
    }
    
    func configurePhoto() {
        if let venuePhoto = venuePhoto, let venuePhotoItems = venuePhoto.items, let venuePhotoInfo = venuePhotoItems.first {
            guard let url = URL(string: "\(venuePhotoInfo.prefix)\(venuePhotoInfo.width)x\(venuePhotoInfo.height)\(venuePhotoInfo.suffix)") else { return }
            venueImageView.sd_setImage(with: url)
            if let venue = venue {
                FoursquareService.shared.imageUrlCache[venue.id] = url
            }
        } else {
            DispatchQueue.main.async {
                self.venueImageView.image = UIImage(named: "nosign")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    func configureDistanceText(forDistance distance: Double) -> String {
        let miles = distance / 1609
        let formattedMiles = Double(floor(100*miles)/100)
        let feet = Int(distance * 3.281)
        
        switch feet {
        case 0...1000:
            return "\(feet) ft"
        default:
            return "\(formattedMiles) mi"
        }
    }
}

// MARK: - API
extension VenueTableViewCell {
    func fetchVenuePhotos(forVenueId venueId: String, withLimit limit: Int, withOffset offset: Int) {
        FoursquareService.shared.fetchVenuePhotos(forVenueId: venueId, withLimit: limit, withOffset: offset) { (venuePhoto) in
            guard let venuePhoto = venuePhoto else { return }
            self.venuePhoto = venuePhoto
        }
    }
}
