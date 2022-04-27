//
//  TabBarVewController.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 24.04.2022.
//

import SwiftUI

final class MainPageBuilder {
    static func build() -> UIViewController {
        let firstViewController = ViewController()
        let secondViewController = SecondViewController()
        
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        firstNavController.tabBarItem.image = UIImage(named: "home.png")

        let secondNavController = UINavigationController(rootViewController: secondViewController)
        secondNavController.tabBarItem.image = UIImage(named: "history.png")
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers([firstNavController, secondNavController], animated: true)
        tabBarViewController.tabBar.tintColor = .black
        tabBarViewController.modalPresentationStyle = .fullScreen
        return tabBarViewController
    }
}
