//
//  MainPresenter.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func setMainData(items: [MainModel])
    func failure(error: Error)
}

protocol MainPresenterProtocol {
    func getMainData()
}

final class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    private let dataManager: DataManagerProtocol?
    
    private var mainDataItems: [Content] = []
    private var generalArray: [MainModel] = []
    
    init(view: MainViewProtocol, dataManager: DataManagerProtocol?) {
        self.view = view
        self.dataManager = dataManager
        getMainData()
    }
    
    func getMainData() {
        dataManager?.getData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.mainDataItems = result
                self.generalArray = result.map({ .init(name: $0.name, id: $0.id, image: UIImage(systemName: "star")) }).compactMap({ $0 })
                view?.setMainData(items: self.generalArray)
            case .failure(let error):
                view?.failure(error: error)
            }
        }
    }
}
