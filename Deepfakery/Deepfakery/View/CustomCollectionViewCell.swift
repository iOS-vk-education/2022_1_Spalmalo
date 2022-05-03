//
//  CustomCollectionViewCell.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 03.05.2022.
//

import UIKit
import Foundation
import Kingfisher

final class CustomCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let resultLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .serik
        addSubview(imageView)
        addSubview(resultLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.frame = .init(x: 0, y: 0, width: bounds.height, height: bounds.height)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        resultLabel.frame = .init(x: bounds.maxX - bounds.height, y: bounds.midY - (bounds.height / 5), width: bounds.height, height: bounds.height / 5)
    }
    
    func setImage(with urlStrinng: String) {
        let url = URL(string: urlStrinng)
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
    }
    
    func setTypeLabel(with type: String) {
        if type != "" {
            resultLabel.text = type
        } else {
            resultLabel.text = "NONE"
        }
    }
}

