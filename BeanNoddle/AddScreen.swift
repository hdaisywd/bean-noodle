//
//  AddScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import Foundation
import UIKit

class AddScreen: UIViewController {
    
    let addImageView = UIView()
    let textView = UITextView()
    let textViewPlaceHolder = "Write a caption..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.title = "New Post"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addImageView)

        NSLayoutConstraint.activate([
            addImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "AddPhotoIcon"), for: .normal)
        view.addSubview(addBtn)

        addBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addBtn.centerXAnchor.constraint(equalTo: addImageView.centerXAnchor),
            addBtn.centerYAnchor.constraint(equalTo: addImageView.centerYAnchor),
        ])

        addBtn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)

        let emotionStackView = UIStackView()
        view.addSubview(emotionStackView)
        emotionStackView.translatesAutoresizingMaskIntoConstraints = false
        emotionStackView.axis = .horizontal
        emotionStackView.distribution = .fillEqually
        emotionStackView.alignment = .fill
        emotionStackView.spacing = 5
        emotionStackView.backgroundColor = .lightGray

        NSLayoutConstraint.activate([
            emotionStackView.leadingAnchor.constraint(equalTo: addImageView.leadingAnchor),
            emotionStackView.trailingAnchor.constraint(equalTo: addImageView.trailingAnchor),
            emotionStackView.topAnchor.constraint(equalTo: addImageView.bottomAnchor, constant: 10),
            emotionStackView.bottomAnchor.constraint(equalTo: addImageView.bottomAnchor, constant: 40)
        ])

        let heartEyesBtn = UIButton()
        heartEyesBtn.setImage(UIImage(named: "heartEyesIcon"), for: .normal)
        heartEyesBtn.imageView?.contentMode = .scaleAspectFit

        let sadBtn = UIButton()
        sadBtn.setImage(UIImage(named: "sadIcon"), for: .normal)
        sadBtn.imageView?.contentMode = .scaleAspectFit

        let itWasOkayBtn = UIButton()
        itWasOkayBtn.setImage(UIImage(named: "itWasOkayIcon"), for: .normal)
        itWasOkayBtn.imageView?.contentMode = .scaleAspectFit
        
        let thinkingBtn = UIButton()
        thinkingBtn.setImage(UIImage(named: "ThinkingIcon"), for: .normal)
        thinkingBtn.imageView?.contentMode = .scaleAspectFit
        
        let angryBtn = UIButton()
        angryBtn.setImage(UIImage(named: "AngryIcon"), for: .normal)
        angryBtn.imageView?.contentMode = .scaleAspectFit

 
        for icon in [heartEyesBtn, sadBtn, itWasOkayBtn, thinkingBtn, angryBtn] {
            emotionStackView.addArrangedSubview(icon)
        }

        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .black
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.trailingAnchor.constraint(equalTo: emotionStackView.trailingAnchor),
            textView.leadingAnchor.constraint(equalTo: emotionStackView.leadingAnchor),
            textView.topAnchor.constraint(equalTo: emotionStackView.bottomAnchor, constant: 10),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLineDot(view: addImageView, color: UIColor.gray, radius: 10)
    }

    @objc func btnAction() {
        let vc = DetailScreen()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func addBtnAction() {
        
    }

    @objc func doneButtonAction() {
        self.dismiss(animated: true)
    }

    func setLineDot(view: UIView, color: UIColor, radius: CGFloat){
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = [5, 5]
        borderLayer.frame = view.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
        view.layer.addSublayer(borderLayer)
    }

    // 이게 없으면 입력을 완료한 걸 인식을 하지 못한다
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }

}

extension AddScreen: UITextViewDelegate {
    public func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
        if textView.text.isEmpty {
            textView.text = "Write a caption..."
            textView.textColor = UIColor.lightGray
        }
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
}
