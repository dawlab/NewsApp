//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by Dawid Łabno on 08/02/2023.
//
import UIKit

class NewsListTableViewController: UITableViewController {
    private var articleListVM: ArticleListViewModel!
    var url: URL!
    let defaults = UserDefaults.standard
    var urlString = UserDefaults.standard.string(forKey: "Category") ?? "https://newsapi.org/v2/everything?q=apple&from=2023-02-07&to=2023-02-07&sortBy=popularity&language=pl&apiKey=d30b951a4e3c40fa930355f474fbe37b"
    
    private lazy var menu = UIMenu(title: "Select your category", children: elements)
    
    private lazy var category0 = UIAction(title: "Top news", image: UIImage(systemName: "list.star"), attributes: [], state: .off) { action in
        self.urlString = "https://newsapi.org/v2/top-headlines?country=pl&apiKey=d30b951a4e3c40fa930355f474fbe37b"
        self.defaults.set(self.urlString, forKey: "Category")
        self.setupWebService(urlString: self.urlString)
    }
    
    private lazy var category1 = UIAction(title: "Apple", image: UIImage(systemName: "apple.logo"), attributes: [], state: .off) { action in
        self.urlString = "https://newsapi.org/v2/everything?q=apple&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
        self.defaults.set(self.urlString, forKey: "Category")
        self.setupWebService(urlString: self.urlString)
    }
    
    private lazy var category2 = UIAction(title: "Tesla", image: UIImage(systemName: "bolt.car"), attributes: [], state: .off) { action in
        self.urlString = "https://newsapi.org/v2/everything?q=tesla&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
        self.defaults.set(self.urlString, forKey: "Category")
        self.setupWebService(urlString: self.urlString)
    }
    
    private lazy var category3 = UIAction(title: "AI", image: UIImage(systemName: "brain"), attributes: [], state: .off) { action in
        self.urlString = "https://newsapi.org/v2/everything?q=gpt-3&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
        self.defaults.set(self.urlString, forKey: "Category")
        self.setupWebService(urlString: self.urlString)
    }
    
    private lazy var category4 = UIAction(title: "Crypto", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), attributes: [], state: .off) { action in
        self.urlString = "https://newsapi.org/v2/everything?q=kryptowaluty&language=pl&sortBy=publishedAt&apiKey=d30b951a4e3c40fa930355f474fbe37b"
        self.defaults.set(self.urlString, forKey: "Category")
        self.setupWebService(urlString: self.urlString)
    }
    
    private lazy var elements: [UIAction] = [category0, category1, category2, category3, category4]

    let selectCategoryButton = UIButton(type: .system)

    private struct Const {
      static let ImageSizeForLargeState: CGFloat = 35
      static let ImageRightMargin: CGFloat = 16
      static let ImageBottomMarginForLargeState: CGFloat = 6
      static let ImageBottomMarginForSmallState: CGFloat = 6
      static let ImageSizeForSmallState: CGFloat = 35
      static let NavBarHeightSmallState: CGFloat = 44
      static let NavBarHeightLargeState: CGFloat = 96.5
    }

    private func setupUI() {
      navigationController?.navigationBar.prefersLargeTitles = true
      title = "NewsApp"

      guard let navigationBar = self.navigationController?.navigationBar else { return }

      navigationBar.addSubview(selectCategoryButton)
        selectCategoryButton.tintColor = .white
        selectCategoryButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        selectCategoryButton.showsMenuAsPrimaryAction = true
        selectCategoryButton.menu = menu

      // setup constraints
      selectCategoryButton.layer.cornerRadius = Const.ImageSizeForLargeState / 2
      selectCategoryButton.clipsToBounds = true
      selectCategoryButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        selectCategoryButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
        selectCategoryButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
        selectCategoryButton.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
        selectCategoryButton.widthAnchor.constraint(equalTo: selectCategoryButton.heightAnchor)
      ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWebService(urlString: urlString)
        
    }
    
    private func setupWebService(urlString: String) {
        let url = URL(string: urlString)!
        
        WebService().getArticles(url: url) { articles in
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        let url = URL(string: articleVM.urlString)!
        UIApplication.shared.open(url)
    }
}
