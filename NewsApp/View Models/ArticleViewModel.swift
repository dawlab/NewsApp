//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Dawid Łabno on 08/02/2023.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}


struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String {
        return self.article.title ?? "No information"
    }
    
    var description: String {
        return self.article.description ?? "No information"
    }
    
    var urlString: String {
        return self.article.url ?? ""
    }
}
