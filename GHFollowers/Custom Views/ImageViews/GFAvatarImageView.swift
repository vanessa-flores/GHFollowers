//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/27/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    // MARK: - Properties
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Helpers
    
    func setImage(fromURL urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
