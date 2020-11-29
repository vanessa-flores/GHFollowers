//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/28/20.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers ?? 0)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following ?? 0)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
