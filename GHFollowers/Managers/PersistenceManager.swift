//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 12/09/21.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower],APIError>)->Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> APIError?{
        do {
            let encoder = JSONEncoder()
            let favorites = try encoder.encode(favorites)
            defaults.setValue(favorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    static func updatewith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (APIError?)->Void) {
        retrieveFavorites { result in
            switch (result){
            case .failure(let error):
                completion(error)
            case .success(var favorites):
                switch (actionType){
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completion(save(favorites: favorites))
            }
        }
    }
}
