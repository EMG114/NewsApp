//
//  SectionCollectionViewCell.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureArticleCollectionCell( article: Article) {
        
        guard let imageNews = article.urlToImage else { return }
        NetworkService.shared.getImage(urlString: imageNews) { [weak self] result in
            DispatchQueue.main.async {
                self?.imageNews.image = result
            }
        }
        
        self.titleLabel.text = article.title
        self.dateLabel.text = article.publishedAt
        
    }
    
}
