//
//  ViewController.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    var articles: [Article] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    //   fetchArticles()
       fethTopHeadlines()
    }
    
    func fetchArticlesByTitle() {
        NetworkService.shared.searchEverythingByTitle(title: "bitcoin") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
            
                self.articles = articles
                print(self.articles)
                self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func fethTopHeadlines() {
        NetworkService.shared.searchTopHeadlines { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
            
                self.articles = articles
                print(self.articles)
                self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error \(error)")
            }
        }
        
    }
    
    

}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as? ArticleTableViewCell else { return UITableViewCell() }
        let article = articles[indexPath.row]
        cell.configureArticleCell(article: article)
        return cell
    }
    
}

extension ArticlesViewController: UITableViewDelegate {
  
}




