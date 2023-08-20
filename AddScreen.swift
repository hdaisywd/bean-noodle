//
//  AddScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import Foundation
import UIKit

class AddScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Post"
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        let dottedBox = UIImageView(image: UIImage(named: "DottedBox"))
        stackView.addArrangedSubview(dottedBox)
        NSLayoutConstraint.activate([
            dottedBox.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "AddPhotoIcon"), for: .normal)
        view.addSubview(addBtn)

        addBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addBtn.centerXAnchor.constraint(equalTo: dottedBox.centerXAnchor),
            addBtn.centerYAnchor.constraint(equalTo: dottedBox.centerYAnchor),
            addBtn.widthAnchor.constraint(equalToConstant: 80),
            addBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addBtn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        
        let captionBox = UITextView()
        captionBox.text = "Write a caption..."
        stackView.addArrangedSubview(captionBox)
        
        NSLayoutConstraint.activate([
            captionBox.heightAnchor.constraint(equalToConstant: 1000)
        ])
    
    }
    
    @objc func btnAction() {
        let vc = DetailScreen()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addBtnAction() {
        
    }
}
