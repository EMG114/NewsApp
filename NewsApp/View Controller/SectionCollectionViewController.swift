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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    
    }
    
}

extension SectionCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
}
