//
//  MainHeader.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import UIKit

struct MainHeaderViewModel {
    let titleText: String
}

class MainHeaderCollectionView: UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: MainHeaderCollectionView.self)
    }
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func set(_ data: MainHeaderViewModel) {
        titleLabel.text = data.titleText
    }
}
