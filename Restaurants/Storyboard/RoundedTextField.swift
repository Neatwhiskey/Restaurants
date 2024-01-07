//
//  RoundedTextField.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 04/01/2024.
//

import UIKit

class RoundedTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    let pad = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 15)
    
    // adding the drawing rectangle for the text field
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //adding the drawing rectangle for the placeholder text
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //adding the editable text rectangle
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // creating the corner radius, borderwidth, bordercolor and masks to bounds of the text fields
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
