//
//  AnimationViewController.swift
//  BottomSheet
//
//  Created by Vladimir Sekerko on 05.10.2022.
//

import Foundation
import UIKit

class AnimationViewController: UIViewController {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "1_6")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        imageView.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.tag = 1
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let petsView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    
    private let idAnimationCell = "idAnimationCell"
    
    private let petsArray = ["1_1", "1_2", "1_3", "1_4", "1_5", "1_6", "1_7", "1_8",
                             "2_1", "2_2", "2_3", "2_4", "2_5", "2_6", "2_7", "2_8"]
    private var isOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.2016450763, green: 0.4917045832, blue: 0.5361617208, alpha: 1)
        
        view.addSubview(photoImageView)
        view.addSubview(petsView)
        view.addSubview(selectButton)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: idAnimationCell)
        petsView.addSubview(collectionView)
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func selectButtonTapped() {
        if isOpen {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.isOpen = false
                self.selectButton.setTitle("Select", for: .normal)
                self.heightConstraint.constant = 20
                self.widthConstraint.constant = 20
                self.bottomConstraint.constant = 0
                self.leadingConstraint.constant = 20
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.isOpen = true
                self.selectButton.setTitle("Close", for: .normal)
                self.heightConstraint.constant = 300
                self.widthConstraint.constant = self.view.frame.width - 40
                self.bottomConstraint.constant = -310
                self.leadingConstraint.constant = self.view.frame.width - 20 - self.selectButton.frame.width
                self.view.layoutIfNeeded()
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension AnimationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idAnimationCell, for: indexPath) as? CollectionViewCell,
              let image = UIImage(named: petsArray[indexPath.row]) else { return UICollectionViewCell() }
        
        cell.configure(image: image)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AnimationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.07,
                      height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: petsArray[indexPath.row])
        photoImageView.image = image
    }
}

//MARK: - setConstraints
extension AnimationViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            photoImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        heightConstraint = NSLayoutConstraint(item: petsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        petsView.addConstraint(heightConstraint)
        
        widthConstraint = NSLayoutConstraint(item: petsView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        petsView.addConstraint(widthConstraint)
        
        NSLayoutConstraint.activate([
            petsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            petsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: petsView.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: petsView.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: petsView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: petsView.trailingAnchor, constant: -10)
        ])
        
        bottomConstraint = NSLayoutConstraint(item: selectButton, attribute: .bottom, relatedBy: .equal, toItem: petsView, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
        
        leadingConstraint = NSLayoutConstraint(item: selectButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        view.addConstraint(leadingConstraint)
        
        NSLayoutConstraint.activate([
            selectButton.heightAnchor.constraint(equalToConstant: 30),
            selectButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
