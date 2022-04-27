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
    private let collectionView: UICollectionView = .init(frame: CGRect(x: 0,
                                                                       y: 80,
                                                                       width: UIScreen.main.bounds.width,
                                                                       height: UIScreen.main.bounds.height - 80),
                                                         collectionViewLayout:UICollectionViewLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        self.addTopNavBar()
        self.addCollectionView()
    }
    
    private func addTopNavBar() {
        self.view.addSubview(self.topNavbar)
        self.topNavbar.backgroundColor = .umud
//        self.topNavbar.addSubview(self.dateLabel)
//        // date label
//        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.dateLabel.text = self.DateAsString()
//        NSLayoutConstraint.activate([
//            self.dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
//            self.dateLabel.topAnchor.constraint(equalTo: self.topNavbar.topAnchor, constant: 50)
//        ])
        
    }
    
    private func addCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
    }
    
}

