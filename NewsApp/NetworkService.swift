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
    
    func searchEverythingByTitle(title: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        
        let urlString = "\(base)everything?q=\(title)&apiKey=\(Secrets.apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response!")
                return
            }
            
            guard let data = data else {
                print("No data was retrieved!")
                return
            }
            
            do {
               let decoder = JSONDecoder()
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
             
                let response = try decoder.decode(Response.self, from: data)
                print(response.articles)
                for article in response.articles {
                   // print(article)
                }
       
              
           
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
}
