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
    
    static func createCameraModule(with id: Int, with name: String) -> UIViewController {
        let view = CameraViewController()
        view.set(id: id, name: name)
        return view
    }
}
