//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/28/20.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowersListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Network Call
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let repoItemViewController = GFRepoItemViewController(user: user)
        repoItemViewController.delegate = self
        
        let followerItemViewController = GFFollowerItemViewController(user: user)
        followerItemViewController.delegate = self
        
        
        self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childViewController: repoItemViewController, to: self.itemViewOne)
        self.add(childViewController: followerItemViewController, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt?.convertToMonthYearFormat() ?? "")"
    }
    
    // MARK: - UI
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        itemViews.forEach { itemView in
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding), 
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}

// MARK: - GFItemInfoViewControllerDelegate

extension UserInfoViewController: GFItemInfoViewControllerDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.profile ?? "") else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard let followers = user.followers, followers > 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers. What a shame 😔.", buttonTitle: "So sad")
            
            return
        }
        delegate?.didRequestFollowers(for: user.username ?? "")
        dismissViewController()
    }
    
}
