//
//  SceneDelegate.swift
//  CriptoWatch
//
//  Created by Fernando Benavides on 17/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    
    private let appCoordiantor = CryptoWatchCoordinator()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Configuring window
        window?.rootViewController = appCoordiantor.rootViewController
        
        // Making window key an visible
        window?.makeKeyAndVisible()
        
        // Starting coordinator
        appCoordiantor.start()
        
    }


}

