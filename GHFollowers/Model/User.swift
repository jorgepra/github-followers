//
//  User.swift
//  GHFollowers
//
//  Created by Jorge Pillaca Ramirez on 7/09/21.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    let name: String
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    //let createdAt: String // we dont need String because of thedateDecodingStrategy
    let createdAt: Date
}
