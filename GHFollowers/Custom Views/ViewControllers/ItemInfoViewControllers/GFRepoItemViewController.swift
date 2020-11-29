//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/28/20.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists ?? 0)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
