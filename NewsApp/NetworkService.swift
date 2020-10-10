//
//  NewtworkService.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import UIKit

enum Category: String, CaseIterable {
    case business, entertainment, general, health, science, sports, technology
}

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
                print(error.localizedDescription)
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
                
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func searchTopHeadlinesByCategory(category: String, completion: @escaping (Result<[Article], NewsError>) -> Void) {
        
        let urlString = "\(base)top-headlines?category=\(category)&country=us&apiKey=\(Secrets.apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidRetrieval))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
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
                
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
                 return
             }
             
             let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                 guard let self = self else { return }
                 if error != nil { return }
                 guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                 //   completion(.failure(.invalidResponse))
                    return
                 }
                 guard let data = data else {
                  //  completion(.failure(.invalidRetrieval))
                    return
                 }
                 
                 guard let image = UIImage(data: data) else {
                  //  completion(.failure(.invalidData))
                    return
                 }
                completion(image)
         
             }
             task.resume()
         }
    
    
}
