//
//  NetworkManager.swift
//  RepoStars
//
//  Created by Erik Nascimento on 12/12/20.
//

import Foundation

class NetworkManager {
    
    static func LoadData(page: Int = 1, completion: @escaping (_ data: RepoModel?) -> Void) {
        
        guard let url = self.buildURL(page: page) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let hasData = data else {
                    completion(nil)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let jData = try decoder.decode(RepoModel.self, from: hasData)
                    completion(jData)
                } catch {
                    completion(nil)
                }
            }
        }
    
        task.resume()
    }
    
    private static func buildURL(page: Int = 1) -> URL? {
        
        var url = URLComponents(string: "https://api.github.com/search/repositories")
        
        let queryItems = [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        url?.queryItems = queryItems
        
        print("URL: \(String(describing: url))")
        
        return url?.url
    }
}
