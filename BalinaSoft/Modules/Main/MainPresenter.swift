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
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        dataManager?.getData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                for item in result {
                    dispatchGroup.enter()
                    dataManager?.loadImage(from: item.image) { image in
                        defer {
                            dispatchGroup.leave()
                        }
                        let viewModel = MainModel(name: item.name, id: item.id, image: image)
                        self.generalArray.append(viewModel)
                    }
                }

            case .failure(let error):
                view?.failure(error: error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.view?.setMainData(items: self.generalArray)
        }
    }
}
