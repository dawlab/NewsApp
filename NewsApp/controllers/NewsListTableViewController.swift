//
//  NewsListTableViewController.swift
//  NewsApp
//
//  Created by Dawid Łabno on 08/02/2023.
//

import UIKit
class NewsListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
