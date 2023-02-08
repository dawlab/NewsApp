//
//  Article.swift
//  NewsApp
//
//  Created by Dawid Łabno on 08/02/2023.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
