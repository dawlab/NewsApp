//
//  Categories.swift
//  NewsApp
//
//  Created by Dawid Łabno on 09/02/2023.
//

import Foundation

struct Categories {
    let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-02-07&to=2023-02-07&sortBy=popularity&language=pl&apiKey=d30b951a4e3c40fa930355f474fbe37b"
}

enum Category: String {
    case topNews = "https://newsapi.org/v2/top-headlines?country=pl&apiKey=d30b951a4e3c40fa930355f474fbe37b"
    case apple = "https://newsapi.org/v2/everything?q=apple&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
    case tesla = "https://newsapi.org/v2/everything?q=tesla&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
    case ai = "https://newsapi.org/v2/everything?q=gpt-3&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
    case crypto = "https://newsapi.org/v2/everything?q=kryptowaluty&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
}
