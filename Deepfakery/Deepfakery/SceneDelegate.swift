//
//  SceneDelegate.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 03.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        let loginPageViewController = LoginPageViewController()
        let tabBarVC = MainPageBuilder.build()
        
        let isUserLogged = UserDefaults.standard.bool(forKey: "isUserLoggined")
        if isUserLogged {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                loginPageViewController.present(tabBarVC, animated: false)
            }
        }
        window?.windowScene = windowScene
        window?.rootViewController = loginPageViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}


