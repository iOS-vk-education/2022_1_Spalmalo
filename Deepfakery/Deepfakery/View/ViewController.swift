//
//  ViewController.swift
//  Calorizoid
//
//  Created by Jasur Tursunov on 23.03.2022.
//

import UIKit
import AVFoundation

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
                                                                       height: UIScreen.main.bounds.height - 80),
                                                         collectionViewLayout:UICollectionViewLayout.init())
    private let dateLabel = UILabel()
    private let cameraButton = UIButton()
    private let galleryButton = UIButton()
    private let startButton = UIButton()
//    private let progressView = UIView()

        
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
        self.addCollectionView()
        
    }
    
    private func addTopNavBar() {
        self.view.addSubview(self.topNavbar)
        self.topNavbar.backgroundColor = .kek
        self.topNavbar.addSubview(self.dateLabel)
        // date label
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.text = UILabel.DateAsString()
        NSLayoutConstraint.activate([
            self.dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.dateLabel.topAnchor.constraint(equalTo: self.topNavbar.topAnchor, constant: 50)
        ])
        
    }
    
    
    private func addCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        
        // camera button
        self.collectionView.addSubview(self.cameraButton)
        self.cameraButton.backgroundColor = .kek
        self.cameraButton.layer.cornerRadius = 20
        self.cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.cameraButton.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 50.0),
            self.cameraButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.cameraButton.widthAnchor.constraint(equalToConstant: 120),
            self.cameraButton.heightAnchor.constraint(equalToConstant: 120)
        ])
        self.cameraButton.addTarget(self, action: #selector(self.onClick(sender:)), for: .touchUpInside)
       // gallery button
        self.collectionView.addSubview(self.galleryButton)
        self.galleryButton.backgroundColor = .serik
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
    }
    
    @objc
    private func onClick(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
        UIImage else {
            return
        }
//        imageView?.image = image
    }
}

extension UILabel {
    static func DateAsString() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "EEEE, MMMM d"
        return dateFormatter.string(from: date as Date)
    }
}


extension UIColor {
    
    static let kek = UIColor.colorWithHexString(hexString: "859F27")
    static let serik = colorWithHexString(hexString: "F4DFA8")
    
    static func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
}
