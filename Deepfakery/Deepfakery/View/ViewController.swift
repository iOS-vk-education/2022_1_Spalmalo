//
//  ViewController.swift
//  Calorizoid
//
//  Created by Jasur Tursunov on 23.03.2022.
//

import UIKit
import AVFoundation
import Firebase
import SwiftUI
import Alamofire

class ViewController: UIViewController {
    private let topNavbar = UINavigationBar(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: UIScreen.main.bounds.width,
                                                          height: 80))
    
    private let bottomNavbar = UINavigationBar(frame: CGRect(x: 0,
                                                             y: UIScreen.main.bounds.maxY - 80,
                                                             width: UIScreen.main.bounds.width,
                                                             height: 80))
    
    private let collectionView: UICollectionView = .init(frame: CGRect(x: 0,
                                                                       y: 80,
                                                                       width: UIScreen.main.bounds.width,
                                                                       height: UIScreen.main.bounds.height - 80),
                                                         collectionViewLayout:UICollectionViewLayout.init())
    private let cameraButton = UIButton()
    private let galleryButton = UIButton()
    private let startButton = UIButton()
    private let logOutButton = UIButton()
    private let imageView = UIImageView()

        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
        
    // MARK: - Configure UI
    
    private func configureUI() {
        self.addTopNavBar()
        self.addCollectionView()
        
    }
    
    private func addTopNavBar() {
        self.view.addSubview(self.topNavbar)
        self.topNavbar.backgroundColor = .umud
        //tabBarItem
    }
    
    
    private func addCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        self.addCameraButton()
        self.addGalleryButton()
//        self.addStartButton()
        self.addLogOutButton()
        self.addImageView()
        
        
    }
    
    private func addLogOutButton() {
        self.collectionView.addSubview(self.logOutButton)
        self.logOutButton.setTitle("Log Out", for: .normal)
        self.logOutButton.setTitleColor(.black, for: .normal)
        self.logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logOutButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.logOutButton.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 10)
        ])
        self.logOutButton.addTarget(self, action: #selector(self.onClickLogoutButton), for: .touchUpInside)
    }
    
    private func addCameraButton() {
        self.collectionView.addSubview(self.cameraButton)
        self.cameraButton.backgroundColor = .umud
        self.cameraButton.layer.cornerRadius = 20
        self.cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.cameraButton.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 80.0),
            self.cameraButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.cameraButton.widthAnchor.constraint(equalToConstant: 120),
            self.cameraButton.heightAnchor.constraint(equalToConstant: 120)
        ])
        self.cameraButton.addTarget(self, action: #selector(self.onClick(sender:)), for: .touchUpInside)
    }
    
    private func addGalleryButton() {
        self.collectionView.addSubview(self.galleryButton)
        self.galleryButton.backgroundColor = .serik
        self.galleryButton.layer.cornerRadius = 20
        self.galleryButton.setImage(UIImage(named: "gallery.png"), for: .normal)
        self.galleryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.galleryButton.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 80.0),
            self.galleryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.galleryButton.widthAnchor.constraint(equalToConstant: 120),
            self.galleryButton.heightAnchor.constraint(equalToConstant: 120)
        ])
        self.galleryButton.addTarget(self, action: #selector(self.onClickGalleryButton(sender:)), for: .touchUpInside)
    }
    
    private func addImageView() {
        self.collectionView.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 250),
            self.imageView.heightAnchor.constraint(equalToConstant: 30),
            self.imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -300)
        ])
    }
    
    private func addStartButton() {
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
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func onClickGalleryButton(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc
    private func onClickLogoutButton() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error occured")
            UserDefaults.standard.set(true, forKey: "isUserLoggined")
        }
        UserDefaults.standard.set(false, forKey: "isUserLoggined")
        self.dismiss(animated: true)
        self.present(MainPageBuilder.build(), animated: false)
        
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else { return }
        self.imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        print("RESULT = \(getResult(image: image))")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func getResult(image: UIImage) -> String {
        let imageData = image.pngData()
        AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(imageData!, withName: "data", fileName: "swift_file.png", mimeType: "image/png")
            },
            to: "http://127.0.0.1:8080/api/v1/photo", method: .post).responseDecodable(of: DecodableType.self) { response in
                switch response.result {
                case .success(let data):
                    print("RESULT = \(data.result.type)")
                case .failure(_):
                    let alert = UIAlertController(title: "Error",
                                                  message: "Something go wrong\nTry again",
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: .default,
                                                  handler: { _ in }))

                    self.present(alert, animated: true)
                }
            }
//        AF.request("http://127.0.0.1:8080/api/v1/photo", method: .post).responseDecodable(of: DecodableType.self) { response in
//            switch response.result {
//            case .success(let data):
//                print(data)
//            case .failure(_):
//                let alert = UIAlertController(title: "Error",
//                                              message: "Something go wrong\nTry again",
//                                              preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "OK",
//                                              style: .default,
//                                              handler: { _ in }))
//
//                self.present(alert, animated: true)
//            }
//        }
        return "jjjj"
    }
}



