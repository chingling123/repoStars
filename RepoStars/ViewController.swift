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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupViews()
    }
}

extension ViewController {
    
    private func setupViews() {
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.headerLabel)
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        
        self.headerLabel.textAlignment = .center
        self.headerLabel.text = "RepoStars"
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 10.0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        
    }
}

