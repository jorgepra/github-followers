//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 8/09/21.
//

import UIKit

class NetworkManager {
    
    fileprivate let baseURL     = "https://api.github.com/users/"
    static let shared           = NetworkManager()
    let cache                   = NSCache<NSString,UIImage>()
    let itemsPerPage            = 100
    
    fileprivate init() {}
    
    func getFollowers(username: String, page: Int, completion: @escaping (Result<[Follower],APIError>)->Void)  {
        let endPoint = baseURL + "\(username)/followers?per_page=\(itemsPerPage)&page=\(page)"
        fetch(urlString: endPoint, completion: completion)
    }
    
    func getUserInfo(username: String, completion: @escaping (Result<User,APIError>)->Void)  {
        let endPoint = baseURL + "\(username)"
        fetch(urlString: endPoint, completion: completion)
    }
    
    func downloadImage(urlString: String, completion: @escaping (UIImage?)->Void)  {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
                
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard 
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
        
            self.cache.setObject(image, forKey: urlString as NSString)
            completion(image)
        }
        task.resume()
    }
    
    
    fileprivate func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T,APIError>)->Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
                                                
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder                  = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let decodedObject            = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
