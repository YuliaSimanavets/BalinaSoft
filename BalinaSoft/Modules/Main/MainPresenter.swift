//
//  MainPresenter.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func setMainData(items: [MainModel])
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
        dataManager?.loadData(dataCollected: { [weak self] result in
            guard let self else { return }
            self.mainDataItems = result
            self.generalArray = result.map({ .init(name: $0.name, id: $0.id) }).compactMap({ $0 })
            
            view?.setMainData(items: self.generalArray)
        })
    }
}
