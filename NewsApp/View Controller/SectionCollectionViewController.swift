//
//  SectionCollectionViewController.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import UIKit

class SectionCollectionViewController: UIViewController {
    
    enum Segment {
        case topHeadlines
        case sources
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
     fetchData()
    }
    
}


// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension SectionCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCollectionViewCell", for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }
        let item = articles[indexPath.item]
        cell.configureArticleCollectionCell(article: item)
        return cell
    }
    
    
    func fetchData() {
        NetworkService.shared.searchTopHeadlinesByCategory(category: .sports) { [weak self] (result) in
            switch result {
            case .success(let businessArray):
                DispatchQueue.main.async {
                    self!.articles = businessArray
                    self?.collectionView.reloadData()
                }
          
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SectionCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width/3)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat{
        return 0
    }

    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
       0
    }
 
    
}
