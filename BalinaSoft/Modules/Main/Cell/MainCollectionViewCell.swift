//
//  MainCollectionViewCell.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation
import UIKit

struct MainModel {
    let name: String
    let id: Int
}

class MainCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier: String {
        return String(describing: MainCollectionViewCell.self)
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(chevronImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -20),
            
            chevronImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func set(_ data: MainModel) {
        nameLabel.text = data.name
    }
}
