//
//  NewsError.swift
//  NewsApp
//
//  Created by Erica on 10/9/20.
//

import Foundation


enum NewsError: String, Error {
    
    case invalidRetrieval = "This request is invalid request. Please try again!."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received froom the server was invalid. Please try again!"
    
}
