//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 8/09/21.
//

import Foundation

enum APIError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Plase try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
