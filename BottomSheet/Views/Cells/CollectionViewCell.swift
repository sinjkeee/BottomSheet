//
//  CollectionViewCell.swift
//  BottomSheet
//
//  Created by Vladimir Sekerko on 22.09.2022.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.2021104097, green: 0.21208781, blue: 0.2119153738, alpha: 1)
        layer.cornerRadius = 10
        
        addSubview(imageView)
    }
    
    func configure(image: UIImage) {
        imageView.image = image
        self.image = image
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
}
