//
//  ViewController.swift
//  Calorizoid
//
//  Created by Jasur Tursunov on 23.03.2022.
//

import UIKit

class ViewController: UIViewController {
    private let topNavbar = UINavigationBar(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: UIScreen.main.bounds.width,
                                                          height: 80))
    
    private let bottomNavbar = UINavigationBar(frame: CGRect(x: 0,
                                                             y: UIScreen.main.bounds.maxY - 80,
                                                             width: UIScreen.main.bounds.width,
                                                             height: 80))
    private let homeButton = UIButton()
    private let historyButton = UIButton()
    
    private let collectionView: UICollectionView = .init(frame: CGRect(x: 0,
                                                                       y: 80,
                                                                       width: UIScreen.main.bounds.width,
                                                                       height: UIScreen.main.bounds.height - 160),
                                                         collectionViewLayout:UICollectionViewLayout.init())
    private let dateLabel = UILabel()
    private let cameraButton = UIButton()
    private let galleryButton = UIButton()
    private let startButton = UIButton()
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
        self.addTopNavBar()
        self.addBottomNavBar()
        self.addCollectionView()
        
    }
    
    private func addTopNavBar() {
        self.view.addSubview(self.topNavbar)
        self.topNavbar.backgroundColor = colorWithHexString(hexString: "859F27")
        self.topNavbar.addSubview(self.dateLabel)
        // date label
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.text = self.DateAsString()
        NSLayoutConstraint.activate([
            self.dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.dateLabel.topAnchor.constraint(equalTo: self.topNavbar.topAnchor, constant: 50)
        ])
        
    }
    
    private func addBottomNavBar() {
        self.view.addSubview(self.bottomNavbar)
        self.bottomNavbar.backgroundColor = colorWithHexString(hexString: "859F27")
        
        //home button
        self.bottomNavbar.addSubview(self.homeButton)
        self.homeButton.setImage(UIImage(named: "home.png"), for: .normal)
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.homeButton.topAnchor.constraint(equalTo: self.bottomNavbar.topAnchor, constant: 20.0),
            self.homeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.homeButton.widthAnchor.constraint(equalToConstant: 32),
            self.homeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        //history button
        self.bottomNavbar.addSubview(self.historyButton)
        self.historyButton.setImage(UIImage(named: "history.png"), for: .normal)
        self.historyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.historyButton.topAnchor.constraint(equalTo: self.bottomNavbar.topAnchor, constant: 20.0),
            self.historyButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.historyButton.widthAnchor.constraint(equalToConstant: 32),
            self.historyButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func addCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        
        // camera button
        self.collectionView.addSubview(self.cameraButton)
        self.cameraButton.backgroundColor = colorWithHexString(hexString: "859F27")
        self.cameraButton.layer.cornerRadius = 20
        self.cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.cameraButton.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 50.0),
            self.cameraButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.cameraButton.widthAnchor.constraint(equalToConstant: 120),
            self.cameraButton.heightAnchor.constraint(equalToConstant: 120)
        ])
       // gallery button
        self.collectionView.addSubview(self.galleryButton)
        self.galleryButton.backgroundColor = colorWithHexString(hexString: "F4DFA8")
        self.galleryButton.layer.cornerRadius = 20
        self.galleryButton.setImage(UIImage(named: "gallery.png"), for: .normal)
        self.galleryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.galleryButton.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 50.0),
            self.galleryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.galleryButton.widthAnchor.constraint(equalToConstant: 120),
            self.galleryButton.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        //start button
        self.collectionView.addSubview(self.startButton)
        self.startButton.backgroundColor = .red
        self.startButton.layer.cornerRadius = 20
        self.startButton.setTitle("GO", for: .normal)
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.startButton.topAnchor.constraint(equalTo: self.cameraButton.bottomAnchor, constant: 50.0),
            self.startButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 110),
            self.startButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -110),
            self.startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //progressview
        self.collectionView.addSubview(self.progressView)
        self.progressView.backgroundColor = .yellow
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.progressView.topAnchor.constraint(equalTo: self.startButton.bottomAnchor, constant: 50.0),
            self.progressView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 110),
            self.progressView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -110),
            self.progressView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
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
