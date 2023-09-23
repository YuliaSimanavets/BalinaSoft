//
//  ModuleBuilder.swift
//  PokemonApplication
//
//  Created by Yuliya on 12/04/2023.
//

import UIKit

final class ModuleBuilder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let dataManager = DataManager()
        let presenter = MainPresenter(view: view, dataManager: dataManager)
        view.set(presenter)
        return view
    }
}
