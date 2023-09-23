//
//  InfoCustomView.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import UIKit

struct CustomViewModel {
    let id: Int
    let name: String
    let image: UIImage?
}

class InfoCustomView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = UIColor.Primary.cellsColor
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func set(_ data: CustomViewModel) {
        imageView.image = data.image
    }
}
