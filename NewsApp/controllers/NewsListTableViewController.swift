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
    let selectCategoryButton = UIButton(type: .system)
    let defaults = UserDefaults.standard
    var urlString = UserDefaults.standard.string(forKey: L10n.categoryKey) ?? Categories().urlString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWebService(urlString: urlString)
        
    }
    
    //    Setup navbar with button
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
        selectCategoryButton.setImage(UIImage(systemName: L10n.rightButtonIcon), for: .normal)
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
    
    //    Button's pull down menu configuration
    private lazy var elements: [UIAction] = [
        topNewsCategory,
        appleCategory,
        teslaCategory,
        aiCategory,
        cryptoCategory]
    
    private lazy var menu = UIMenu(title: L10n.selectCategory, children: elements)
    
    func changeNewsSource(from category: Category) {
        urlString = category.rawValue
        defaults.set(self.urlString, forKey: L10n.categoryKey)
        setupWebService(urlString: self.urlString)
    }
    
    private lazy var topNewsCategory = UIAction(title: L10n.topNewsCategory, image: UIImage(systemName: L10n.topNewsCategoryIcon), attributes: [], state: .off) { action in
        self.changeNewsSource(from: Category.topNews)
    }
    
    private lazy var appleCategory = UIAction(title: L10n.appleCategory, image: UIImage(systemName: L10n.appleCategoryIcon), attributes: [], state: .off) { action in
        self.changeNewsSource(from: Category.apple)
    }
    
    private lazy var teslaCategory = UIAction(title: L10n.teslaCategory, image: UIImage(systemName: L10n.teslaCategoryIcon), attributes: [], state: .off) { action in
        self.changeNewsSource(from: Category.tesla)
    }
    
    private lazy var aiCategory = UIAction(title: L10n.aiCategory, image: UIImage(systemName: L10n.aiCategoryIcon), attributes: [], state: .off) { action in
        self.changeNewsSource(from: Category.ai)
    }
    
    private lazy var cryptoCategory = UIAction(title: L10n.cryptoCategory, image: UIImage(systemName: L10n.cryptoCategoryIcon), attributes: [], state: .off) { action in
        self.changeNewsSource(from: Category.crypto)
    }
    
    //    Web service implementation
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
    
    //    TableView configuration
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
