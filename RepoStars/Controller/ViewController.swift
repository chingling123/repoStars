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
    
    private lazy var loadLabel: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.backgroundColor = .white
        l.text = "Carregando..."
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let dataSource = RepoDataSource()
    private let cellIdentifier = "repoStarCell"
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.Setup()
        
        self.loadData()
    }
    
    private func loadData() {
        self.dataSource.load()
    }
    
    @objc private func pullToRefresh() {
        self.dataSource.currentPage = 1
        self.dataSource.refresh()
    }
}

extension ViewController: ViewCodeProtocol {
    func AddSubViews() {
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.loadLabel)
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
        
        self.loadLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.loadLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.loadLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func Setup() {
        AddSubViews()
        ConfigureConstraints()
        
        self.view.backgroundColor = .white
        
        self.tableView.register(RepoStarTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = 60.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.refreshControl = refreshControl
        
        self.refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        
        self.dataSource.delegate = self
    }

}

extension ViewController: RepoDataSourceDelegate {
    func fetchCompleted(indexes: [IndexPath]?) {
        guard let hasIndexes = indexes else {
            self.loadLabel.isHidden = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            return
        }
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: hasIndexes, with: .automatic)
        self.tableView.endUpdates()
        self.loadLabel.isHidden = true
    }
    
    func fetchError() {
        self.loadLabel.isHidden = true
        let uiA = UIAlertController(title: "Erro", message: "Erro ao carregar dados", preferredStyle: .alert)
        uiA.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        self.present(uiA, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.itemsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RepoStarTableViewCell else { return UITableViewCell() }
        
        cell.setup(item: self.dataSource.itemsToDisplay[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.dataSource.itemsToDisplay.count - 1) {
            self.loadLabel.isHidden = false
            self.dataSource.load()
        }
    }
}
