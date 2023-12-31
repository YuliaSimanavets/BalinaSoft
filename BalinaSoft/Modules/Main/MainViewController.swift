//
//  MainViewController.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var presenter: MainPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()

    private var mainArrayModel: [MainModel] = []
       
    private let mainHeaderTitle = "Make a choice 🔽"
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Primary.backColor
        view.addSubview(mainCollectionView)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(MainCollectionViewCell.self,
                                    forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        mainCollectionView.register(MainHeaderCollectionView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: MainHeaderCollectionView.identifier)
        
        setupConstraints()
        createActivityIndicator()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func createActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.style = .medium
        activityIndicator.color = .orange
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func set(_ presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainArrayModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }

        let item = mainArrayModel[indexPath.item]
        cell.set(item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionView.identifier, for: indexPath) as? MainHeaderCollectionView else { return UICollectionReusableView() }

        let item = mainHeaderTitle
        header.set(.init(titleText: item))
        return header
    }
    
    func tapOnCellAction(_ indexPath: IndexPath) {
        let dataId = mainArrayModel[indexPath.item].id
        let dataName = mainArrayModel[indexPath.item].name
        let cameraViewController = ModuleBuilder.createCameraModule(with: dataId, with: dataName)
        navigationController?.pushViewController(cameraViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        let item = mainArrayModel[indexPath.item]
        return MainCollectionViewCell.size(item, containerSize: frame.size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 60)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapOnCellAction(indexPath)
    }
}

extension MainViewController: MainViewProtocol {
    
    func setMainData(items: [MainModel]) {
        self.mainArrayModel = items
        activityIndicator.stopAnimating()
        mainCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Something was wrong :(",
                                                message: "Please, try again later",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        print(error.localizedDescription)
    }
}
