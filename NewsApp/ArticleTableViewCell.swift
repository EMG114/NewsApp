//
//  ArticleCellTableViewCell.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var imageArticle: UIImageView!
    
    @IBOutlet weak var titleArticle: UILabel!
    
    @IBOutlet weak var descriptionArticle: UILabel!
    
    @IBOutlet weak var datePublished: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureArticleCell( article: Article) {

        guard let imageUrl = article.urlToImage else { return }
        NetworkService.shared.getImage(urlString: imageUrl) { [weak self ] result in
            DispatchQueue.main.async {
                print("*************")
                self?.imageArticle.image = result
            }
            
            

        }
   
        self.titleArticle.text = article.title
        self.descriptionArticle.text = article.articleDescription
        self.datePublished.text = article.publishedAt

    }

}
