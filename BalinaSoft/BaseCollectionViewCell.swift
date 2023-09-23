//
//  BaseCollectionViewCell.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
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
    
    func setupView() {}
}
