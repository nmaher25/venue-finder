//
//  VenueSearchEmptyState.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/18/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit

class VenueSearchEmptyState: UIView {
    
    // MARK: - Properties
    lazy var emptyStateTitle: UILabel = {
        let label = UILabel()
        
        label.font = Styler.Font.largeBold
        label.textColor = Styler.Color.textNormal
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Search to find Venues"
        
        return label
    }()
    
    lazy var emptyStateBody: UILabel = {
        let label = UILabel()
        
        label.font = Styler.Font.mediumNormal
        label.textColor = Styler.Color.textLight
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "You can search the name of a location, or tap the location button in the top right to search your location!\nProvide a keyword to narrow down results and find what you're lookin' for."
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
        backgroundColor = .white
        let stack = UIStackView(arrangedSubviews: [emptyStateTitle, emptyStateBody])
        stack.axis = .vertical
        stack.spacing = Styler.Margin.large
        stack.alignment = .center
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: Styler.Margin.large).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -Styler.Margin.large).isActive = true
    }
    
}
