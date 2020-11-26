//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/26/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com"
    let perPageFollowers = 100
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again.")
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, "Unable to complete your request. Please check your internet connection.")
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again.")
                
                return
            }
            
            guard let data = data else {
                completion(nil, "The data received from the server was invalid. Please try again.")
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
                
            } catch {
                completion(nil, "The data received from the server was invalid. Please try again.")
            }
        }
        
        task.resume()
    }
}
