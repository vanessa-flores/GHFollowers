//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/28/20.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    
    // MARK: - Properties
    
    weak var delegate: GFRepoItemViewControllerDelegate?
    
    // MARK: - Initializers
    
    init(user: User, delegate: GFRepoItemViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    // MARK: - UI Configuration
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists ?? 0)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    // MARK: - Actions
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
