//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/29/20.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    var searchNavigationController: UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    var favoritesNavigationController: UINavigationController {
        let favoritesViewController = FavoritesListViewController()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesViewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [searchNavigationController, favoritesNavigationController]
    }
    
}
