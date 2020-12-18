//
//  Utilities.swift
//  VenueFinder
//
//  Created by Nicholas Maher on 12/17/20.
//  Copyright © 2020 Nicholas Maher. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func inputContainerView(textField: UITextField) -> UIView {
        let view = UIView()
        //view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        dividerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dividerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        return view
    }
    
    static func textField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return textField
    }
}
