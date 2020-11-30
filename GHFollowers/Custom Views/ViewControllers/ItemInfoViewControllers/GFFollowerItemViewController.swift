//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/28/20.
//

import UIKit

protocol GFFollowerItemViewControllerDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFFollowerItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers ?? 0)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following ?? 0)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
}
