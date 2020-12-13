//
//  RepoStarTableViewCell.swift
//  RepoStars
//
//  Created by Erik Nascimento on 13/12/20.
//

import UIKit

class RepoStarTableViewCell: UITableViewCell {

    private let avatar = UIImageView()
    private let repoNameLabel = UILabel()
    private let authorNameLabel = UILabel()
    private let starsLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.Setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(item: itemRepo) {
        self.authorNameLabel.text = item.owner.login
        self.repoNameLabel.text = item.name
        self.starsLabel.text = "\(item.stargazers_count)"
    }

}

extension RepoStarTableViewCell: ViewCodeProtocol {
    func AddSubViews() {
        self.addSubview(self.avatar)
        self.addSubview(self.authorNameLabel)
        self.addSubview(self.repoNameLabel)
        self.addSubview(self.starsLabel)
    }
    
    func ConfigureConstraints() {
        self.avatar.translatesAutoresizingMaskIntoConstraints = false
        self.avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        self.avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5.0).isActive = true
        self.avatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5.0).isActive = true
        self.avatar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        self.authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameLabel.leftAnchor.constraint(equalTo: self.avatar.rightAnchor, constant: 5.0).isActive = true
        self.authorNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        self.authorNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
        
        self.repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.repoNameLabel.leftAnchor.constraint(equalTo: self.avatar.rightAnchor, constant: 5.0).isActive = true
        self.repoNameLabel.topAnchor.constraint(equalTo: self.authorNameLabel.bottomAnchor, constant: 5.0).isActive = true
        self.repoNameLabel.rightAnchor.constraint(equalTo: self.starsLabel.leftAnchor, constant: 5.0).isActive = true
        
        self.starsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.starsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
        self.starsLabel.topAnchor.constraint(equalTo: self.repoNameLabel.topAnchor).isActive = true
        self.starsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5.0).isActive = true
    }
    
    func Setup() {
        AddSubViews()
        ConfigureConstraints()
    }
}
