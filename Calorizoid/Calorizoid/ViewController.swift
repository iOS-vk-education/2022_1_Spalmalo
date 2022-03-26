//
//  ViewController.swift
//  Calorizoid
//
//  Created by Jasur Tursunov on 23.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                                y: 80,
                                                                width: UIScreen.main.bounds.width,
                                                                height: UIScreen.main.bounds.height),
                                                  collectionViewLayout:UICollectionViewLayout.init())
    private let navbar = UINavigationBar(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: UIScreen.main.bounds.width,
                                                       height: 80))
    
    private let mainView = UIView()
    
    private let navbarMenuButton = UIButton()
    
    private let dateLabel = UILabel()
    
    private let progressView = UIView()

        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
        
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//        }
//
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//        }
//
//        override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//        }
        
    // MARK: - Configure UI
    
    private func configureUI() {
        self.addNavBar()
        self.addCollectionView()
    }
    
    private func addNavBar() {
        self.view.addSubview(self.navbar)
        self.navbar.backgroundColor = colorWithHexString(hexString: "859F27")
        self.navbar.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.text = self.DateAsString()
        self.dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.dateLabel.topAnchor.constraint(equalTo: self.navbar.topAnchor, constant: 50).isActive = true
    }
    
    private func addCollectionView() {
        self.view.addSubview(self.mainView)
//        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.backgroundColor = .white
        self.mainView.frame = CGRect(x: 0,
                                     y: self.navbar.frame.size.height,
                                     width: view.frame.size.width,
                                     height: view.frame.size.height - self.navbar.frame.size.height)
        self.mainView.addSubview(self.progressView)
        self.progressView.backgroundColor = .yellow
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        self.progressView.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 300).isActive = true
    }
    
    
}


extension ViewController {
    
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
    
    func DateAsString() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "EEEE, MMMM d"
        return dateFormatter.string(from: date as Date)
    }
}
