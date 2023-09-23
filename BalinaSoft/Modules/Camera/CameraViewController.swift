//
//  CameraViewController.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation
import UIKit

class CameraViewController: UIViewController {

    private var infoCustomView = InfoCustomView()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var id = Int()
    private var name = String()
    
    private let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Take picture", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.Primary.cellsColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Primary.backColor
        view.addSubview(infoCustomView)
        view.addSubview(button)
        setupConstraints()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoCustomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoCustomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoCustomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoCustomView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            
            button.leadingAnchor.constraint(equalTo: infoCustomView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: infoCustomView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func set(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    @objc
    func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension CameraViewController: UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        imageView.image = image
        infoCustomView.set(.init(id: self.id, name: self.name, image: image))
    }
}
