//
//  ViewController.swift
//  BottomSheet
//
//  Created by Vladimir Sekerko on 22.09.2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var selectDogsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select cats", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .black
        button.backgroundColor = #colorLiteral(red: 0.3910655677, green: 0.8353805542, blue: 0.2646413445, alpha: 1)
        button.layer.cornerRadius = 20
        button.tag = 0
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var selectCatsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select dogs", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .black
        button.backgroundColor = #colorLiteral(red: 0.5722479224, green: 0.5730136633, blue: 0.5466012955, alpha: 1)
        button.layer.cornerRadius = 20
        button.tag = 1
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.image = UIImage(named: "1_1")
        view.contentMode = .scaleAspectFill
        view.layer.borderColor = #colorLiteral(red: 0.2016450763, green: 0.4917045832, blue: 0.5361617208, alpha: 1)
        view.tintColor = .systemBlue
        view.layer.borderWidth = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dogsArray = ["1_1", "1_2", "1_3", "1_4", "1_5", "1_6", "1_7", "1_8"]
    private let catsArray = ["2_1", "2_2", "2_3", "2_4", "2_5", "2_6", "2_7", "2_8"]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1015320346, green: 0.2931124568, blue: 0.3515934944, alpha: 1)
        
        view.addSubview(selectDogsButton)
        view.addSubview(selectCatsButton)
        view.addSubview(photoImageView)
    }

    @objc private func selectButtonTapped(_ sender: UIButton) {
        showMyViewControllerInCustomSheet(array: sender.tag == 0 ? catsArray : dogsArray,
                                          textLabel: sender.tag == 0 ? "Select cat" : "Select dog")
    }
    
    private func showMyViewControllerInCustomSheet(array: [String], textLabel: String) {
        let viewControllerToPresent = BottomSheetViewController()
        viewControllerToPresent.petsArray = array
        viewControllerToPresent.topLabel.text = textLabel
        viewControllerToPresent.selectCollectionViewDelegate = self
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }

}

extension ViewController: SelectPetProtocol {
    func selectPet(image: UIImage) {
        photoImageView.image = image
    }
}

extension ViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 300),
            photoImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            selectCatsButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 30),
            selectCatsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectCatsButton.heightAnchor.constraint(equalToConstant: 60),
            selectCatsButton.widthAnchor.constraint(equalToConstant: 150),
            
            selectDogsButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 30),
            selectDogsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectDogsButton.heightAnchor.constraint(equalToConstant: 60),
            selectDogsButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

