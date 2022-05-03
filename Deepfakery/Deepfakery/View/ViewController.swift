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
import FirebaseStorage


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
    private let clearButton = UIButton()
    private let goButton = UIButton()
    private let saveButton = UIButton()

    private let imageView = UIImageView()
    private let resultLabel = UILabel()

        
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
        self.addImageView()
        self.addResultLabel()
        self.addCameraButton()
        self.addGalleryButton()
        self.addClearButton()
        self.addGoButton()
        self.addSaveButton()
        self.addLogOutButton()
               
        
    }
    
    private func addImageView() {
        self.view.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.backgroundColor = .white
        self.imageView.image = UIImage(named: "deepfake.png")
        self.imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topNavbar.bottomAnchor, constant: 20),
            self.imageView.heightAnchor.constraint(equalToConstant: 350),
            self.imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            self.imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
        ])
    }
    
    private func addResultLabel() {
        self.collectionView.addSubview(self.resultLabel)
        self.resultLabel.textColor = .black
        self.resultLabel.font = UIFont(name: "Avenir-Light", size: 25)
        self.resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.resultLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.resultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    
    private func addCameraButton() {
        self.collectionView.addSubview(self.cameraButton)
        self.cameraButton.backgroundColor = .umud
        self.cameraButton.layer.cornerRadius = 20
        self.cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.cameraButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 60.0),
            self.cameraButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.cameraButton.widthAnchor.constraint(equalToConstant: 120),
            self.cameraButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.cameraButton.addTarget(self, action: #selector(self.onClickCameraButton(sender:)), for: .touchUpInside)
    }
    
    private func addGalleryButton() {
        self.collectionView.addSubview(self.galleryButton)
        self.galleryButton.backgroundColor = .serik
        self.galleryButton.layer.cornerRadius = 20
        self.galleryButton.setImage(UIImage(named: "gallery.png"), for: .normal)
        self.galleryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.galleryButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 60.0),
            self.galleryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.galleryButton.widthAnchor.constraint(equalToConstant: 120),
            self.galleryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.galleryButton.addTarget(self, action: #selector(self.onClickGalleryButton(sender:)), for: .touchUpInside)
    }
    
    private func addClearButton() {
        self.collectionView.addSubview(self.clearButton)
        self.clearButton.backgroundColor = .serik
        self.clearButton.layer.cornerRadius = 20
        self.clearButton.setImage(UIImage(named: "trash.png"), for: .normal)
        self.clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.clearButton.topAnchor.constraint(equalTo: self.cameraButton.bottomAnchor, constant: 20.0),
            self.clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.clearButton.widthAnchor.constraint(equalToConstant: 120),
            self.clearButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.clearButton.addTarget(self, action: #selector(self.onClickClearButton(sender:)), for: .touchUpInside)
    }
    
    private func addGoButton() {
        self.collectionView.addSubview(self.goButton)
        self.goButton.backgroundColor = .umud
        self.goButton.layer.cornerRadius = 20
        self.goButton.setImage(UIImage(named: "go.png"), for: .normal)
        self.goButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.goButton.topAnchor.constraint(equalTo: self.galleryButton.bottomAnchor, constant: 20.0),
            self.goButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.goButton.widthAnchor.constraint(equalToConstant: 120),
            self.goButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.goButton.addTarget(self, action: #selector(self.onClickGoButton(sender:)), for: .touchUpInside)
    }
    
    
    private func addSaveButton() {
        self.collectionView.addSubview(self.saveButton)
        self.saveButton.backgroundColor = .umud
        self.saveButton.layer.cornerRadius = 20
        self.saveButton.setImage(UIImage(named: "save.png"), for: .normal)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 200.0),
            self.saveButton.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            self.saveButton.widthAnchor.constraint(equalToConstant: 120),
            self.saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.saveButton.addTarget(self, action: #selector(self.onClickSaveButton(sender:)), for: .touchUpInside)
    }
    
    
    private func addLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(self.onClickLogoutButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func getResult(image: UIImage) {
        //https://deepfakery.herokuapp.com/api/v1/photo
        let imageData = image.pngData()
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "data", fileName: "swift_file.png", mimeType: "image/png")
        },
                  to: "http://127.0.0.1:5000/api/v1/photo", method: .post).responseDecodable(of: DecodableType.self) { response in
            switch response.result {
            case .success(let data):
                if data.result.type == "REAL" {
                    self.resultLabel.text = data.result.type + "  ✅"
                } else {
                    self.resultLabel.text = data.result.type + "  ❌"
                }
                
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
    }
    
    private func upload(currentUserId: String, image: UIImage, completion: @escaping(Result<URL, Error>) -> Void) {
        let reference = Storage.storage().reference().child(currentUserId)
        
//        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        guard let imageData = image.pngData() else { return }
        reference.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("ERROR = \(error!)")
                completion(.failure(error!))
                return
            }
            reference.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
            
        }
    }
    
    @objc
    private func onClickCameraButton(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc
    func onClickGalleryButton(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc
    func onClickGoButton(sender: UIButton) {
        guard let image = self.imageView.image else { return }
        self.getResult(image: image)
    }
    
    @objc
    func onClickClearButton(sender: UIButton) {
        self.resultLabel.text = ""
        self.imageView.image = UIImage(named: "deepfake.png")
    }
    
    
    @objc
    func onClickSaveButton(sender: UIButton) {
        self.upload(currentUserId: Auth.auth().currentUser!.uid, image: self.imageView.image!) {
            (result) in
            switch result {
            case .success(let url):
                let db = Firestore.firestore()
                db.collection("user_images").addDocument(data: [
                    "imageURL": url.absoluteString,
                    "type": self.resultLabel.text,
                    "uuid": Auth.auth().currentUser!.uid,
                ])
                let alert = UIAlertController(title: "Success",
                                              message: "Image saved",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in }))
                
                self.present(alert, animated: true)
                self.collectionView.reloadData()
            case .failure(_):
                return
            }
        }
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
        self.resultLabel.text = ""
//        print("RESULT = \(getResult(image: image))")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



