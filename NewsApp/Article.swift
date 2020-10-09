//
//  Article.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//


import UIKit

struct Article: Codable {
    let source: Source
    let author: String?
    var title: String
    var articleDescription: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
    
    enum CodingKeys: String, CodingKey {
           case source, author, title, url
           case urlToImage
           case publishedAt
           case articleDescription = "description"
       }
    
}
