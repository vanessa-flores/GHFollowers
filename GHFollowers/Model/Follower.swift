//
//  Follower.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/26/20.
//

import Foundation

struct Follower {
    
    var username: String?
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case username   = "login"
        case avatarURL  = "avatar_url"
    }
}
