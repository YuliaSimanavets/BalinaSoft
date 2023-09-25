//
//  CameraViewController.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation
import UIKit

class CameraViewController: UIViewController {

    private var presenter: CameraPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.badge.ellipsis")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let takePictureButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Take picture", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.Primary.cellsColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let postButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Primary.backColor
        view.addSubview(imageView)
        imageView.addSubview(cameraImageView)
        view.addSubview(takePictureButton)
        view.addSubview(postButton)
        setupConstraints()
        
        takePictureButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: takePictureButton.topAnchor, constant: -20),
            
            cameraImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            cameraImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            cameraImageView.heightAnchor.constraint(equalToConstant: 50),
            cameraImageView.widthAnchor.constraint(equalToConstant: 50),
            
            takePictureButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            takePictureButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            takePictureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            takePictureButton.heightAnchor.constraint(equalToConstant: 50),
            
            postButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            postButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            postButton.topAnchor.constraint(equalTo: takePictureButton.topAnchor),
            postButton.bottomAnchor.constraint(equalTo: takePictureButton.bottomAnchor)
        ])
    }
    
    private func createActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.style = .medium
        activityIndicator.color = .orange
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func set(_ presenter: CameraPresenterProtocol) {
        self.presenter = presenter
    }
    
    @objc
    func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc
    func didTapPost() {
        guard let image = imageView.image else { return }
        presenter?.uploadData(photo: image)
        createActivityIndicator()
    }
}

extension CameraViewController: UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.image = image
        cameraImageView.isHidden = true
        postButton.backgroundColor = UIColor.Primary.cellsColor
    }
}

extension CameraViewController: CameraViewProtocol {
    
    func success() {
        activityIndicator.stopAnimating()
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Something was wrong :(",
                                                message: "Please, try again later",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
