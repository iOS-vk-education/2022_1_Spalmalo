//
//  SecondViewController.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 03.04.2022.
//

import UIKit

class SecondViewController: UIViewController {
    private let topNavbar = UINavigationBar(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: UIScreen.main.bounds.width,
                                                          height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        self.addTopNavBar()
    }
    
    private func addTopNavBar() {
        self.view.addSubview(self.topNavbar)
        self.topNavbar.backgroundColor = .kek
//        self.topNavbar.addSubview(self.dateLabel)
//        // date label
//        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.dateLabel.text = self.DateAsString()
//        NSLayoutConstraint.activate([
//            self.dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
//            self.dateLabel.topAnchor.constraint(equalTo: self.topNavbar.topAnchor, constant: 50)
//        ])
        
    }
    
}

