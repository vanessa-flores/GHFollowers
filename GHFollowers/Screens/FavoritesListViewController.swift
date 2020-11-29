//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/25/20.
//

import UIKit

class FavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        getFavorites()
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Network Call
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }

}
