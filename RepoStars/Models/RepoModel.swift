//
//  RepoModel.swift
//  RepoStars
//
//  Created by Erik Nascimento on 12/12/20.
//

import Foundation

struct RepoModel: Codable {
    let total_count: Int
    var items: [itemRepo]
}

struct itemRepo: Codable {
    let id: Int
    let name: String
    let full_name: String
    let stargazers_count: Int
    let owner: itemOwner
}

struct itemOwner: Codable {
    let login: String
    let avatar_url : String
    
}
