//
//  DataSource.swift
//  RepoStars
//
//  Created by Erik Nascimento on 12/12/20.
//

import Foundation

class RepoDataSource {
    func load(page: Int = 1, completion: @escaping (_ results: RepoModel?) -> Void)
    {
        NetworkManager.LoadData { (data) in
            completion(data)
        }
    }
}
