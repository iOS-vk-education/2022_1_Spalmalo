//
//  SecondViewController.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 03.04.2022.
//

import UIKit
import FirebaseStorage
import Firebase



class SecondViewController: UIViewController {
    private let topNavbar = UINavigationBar(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: UIScreen.main.bounds.width,
                                                          height: 80))
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect(x: 0,
                                                y: 80,
                                                width: UIScreen.main.bounds.width,
                                                height: UIScreen.main.bounds.height - 150),
                                  collectionViewLayout: collectionLayout)
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    
    private let db = Firestore.firestore()
    private var documents: [Document] = []
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    
    private func getData() {
        self.db.collection("user_images").whereField("uuid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (query, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.documents = []
                for document in query!.documents {
                    let dict = document.data()
                    guard let url = dict["imageURL"] else { continue }
                    guard let uuid = dict["uuid"] else { continue }
                    guard let type = dict["type"] else { continue }

                    let oneData: Document = Document(uuid: uuid as! String,
                                                     url: url as! String,
                                                     type: type as! String)
                    self.documents.append(oneData)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.getData()
        return self.documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell
        cell?.setImage(with: self.documents[indexPath.row].url)
        cell?.setTypeLabel(with: self.documents[indexPath.row].type)
        return cell ?? .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 2
        let cellHeight = (collectionView.frame.width - 2) / 5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
