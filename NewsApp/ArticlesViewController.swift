//
//  ViewController.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkService.shared.searchEverythingByTitle(title: "bitcoin") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles.append(contentsOf: articles)
            case .failure(let error):
                print("Error \(error)")
            }
        }
        print(articles)
    }

}




