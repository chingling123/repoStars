//
//  ViewController.swift
//  RepoStars
//
//  Created by Erik Nascimento on 12/12/20.
//

import UIKit

class ViewController: UIViewController {

    let headerLabel = UILabel()
    let tableView = UITableView()
    
    private var repoData: RepoModel?
    private let dataSource = RepoDataSource()
    private var pageN = 1
    private let cellIdentifier = "repoStarCell"
    private let refreshControl = UIRefreshControl()
    
    convenience init(item: RepoModel? = nil) {
        self.init()
        self.repoData = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.Setup()
        
        if self.repoData == nil {
            self.loadData()
        }
    }
    
    private func loadData() {
        self.dataSource.load(page: pageN) { (result) in
            DispatchQueue.main.async {
                guard let hasResult = result else { return }
                self.repoData = hasResult
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc private func pullToRefresh() {
        self.loadData()
    }
}

extension ViewController: ViewCodeProtocol {
    func AddSubViews() {
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.tableView)
    }
    
    func ConfigureConstraints() {
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.headerLabel.textAlignment = .center
        self.headerLabel.text = "RepoStars"
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 10.0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func Setup() {
        AddSubViews()
        ConfigureConstraints()
        
        self.view.backgroundColor = .white
        
        self.tableView.register(RepoStarTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = 60.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.refreshControl = refreshControl
        
        self.refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoData?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RepoStarTableViewCell else { return UITableViewCell() }
        
        if let hasItem = self.repoData?.items[indexPath.row] {
            cell.setup(item: hasItem)
        }
        
        return cell
    }
}
