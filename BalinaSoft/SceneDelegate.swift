//
//  SceneDelegate.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
       
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let viewController = MainViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

