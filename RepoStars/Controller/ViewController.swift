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
            }
        }
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
        self.headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.headerLabel.textAlignment = .center
        self.headerLabel.text = "RepoStars"
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 10.0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func Setup() {
        AddSubViews()
        ConfigureConstraints()
        
        self.tableView.dataSource = self
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoData?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
