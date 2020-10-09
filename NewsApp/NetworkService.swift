//
//  NewtworkService.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import Foundation

class NetworkService {
    
    let base = "https://newsapi.org/v2/"
    
    static let shared = NetworkService()
    
    private init() {}
    
    func searchEverythingByTitle(title: String, completion: @escaping (Result<[Article], NewsError>) -> Void) {
        
        let urlString = "\(base)everything?q=\(title)&apiKey=\(Secrets.apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidRetrieval))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(Response.self, from: data)
                
                completion(.success(response.articles))
                
            } catch let error {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
}
