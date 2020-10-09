//
//  Response.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import Foundation

struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles:[Article]
}
