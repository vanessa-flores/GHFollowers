//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/29/20.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
