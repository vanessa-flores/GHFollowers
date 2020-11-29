//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vanessa Flores on 11/26/20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com"
    let perPageFollowers = 100
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
                
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
                
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
