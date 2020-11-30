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
}
