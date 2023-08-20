//
//  AddScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import Foundation
import UIKit
import CoreData

class AddScreen: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var selectedImages = UIImageView()
    let addImageView = UIView()
    let textView = UITextView()
    let textViewPlaceHolder = "Write a caption..."
    
    var imageList = [Data]()
    
    // emotion Button 모음
    var emotionSelectedNumber = 0
    let heartEyesBtn = UIButton()
    let sadBtn = UIButton()
    let itWasOkayBtn = UIButton()
    let thinkingBtn = UIButton()
    let angryBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.title = "New Post"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonAction))
        
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addImageView)

        NSLayoutConstraint.activate([
            addImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        let addPhotoBtn = UIButton()
        addPhotoBtn.setImage(UIImage(named: "AddPhotoIcon"), for: .normal)
        addPhotoBtn.imageView?.contentMode = .scaleAspectFit
        addPhotoBtn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        addPhotoBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addPhotoBtn)
        
        NSLayoutConstraint.activate([
            addPhotoBtn.centerXAnchor.constraint(equalTo: addImageView.centerXAnchor),
            addPhotoBtn.centerYAnchor.constraint(equalTo: addImageView.centerYAnchor),
            addPhotoBtn.widthAnchor.constraint(equalToConstant: 100),
            addPhotoBtn.heightAnchor.constraint(equalToConstant: 100)
        ])

        selectedImages.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedImages)
        
        NSLayoutConstraint.activate([
            selectedImages.trailingAnchor.constraint(equalTo: addImageView.trailingAnchor),
            selectedImages.leadingAnchor.constraint(equalTo: addImageView.leadingAnchor),
            selectedImages.topAnchor.constraint(equalTo: addImageView.topAnchor),
            selectedImages.bottomAnchor.constraint(equalTo: addImageView.bottomAnchor)
        ])

        let emotionStackView = UIStackView()
        view.addSubview(emotionStackView)
        emotionStackView.translatesAutoresizingMaskIntoConstraints = false
        emotionStackView.axis = .horizontal
        emotionStackView.distribution = .fillEqually
        emotionStackView.alignment = .fill
        emotionStackView.spacing = 5

        NSLayoutConstraint.activate([
            emotionStackView.leadingAnchor.constraint(equalTo: addImageView.leadingAnchor),
            emotionStackView.trailingAnchor.constraint(equalTo: addImageView.trailingAnchor),
            emotionStackView.topAnchor.constraint(equalTo: addImageView.bottomAnchor, constant: 10),
            emotionStackView.bottomAnchor.constraint(equalTo: addImageView.bottomAnchor, constant: 40)
        ])

        // emotion button 생성
        heartEyesBtn.setImage(UIImage(named: "heartEyesIcon"), for: .normal)
        heartEyesBtn.imageView?.contentMode = .scaleAspectFit
        heartEyesBtn.addTarget(self, action: #selector(heartEyesBtnAction), for: .touchUpInside)

        sadBtn.setImage(UIImage(named: "sadIcon"), for: .normal)
        sadBtn.imageView?.contentMode = .scaleAspectFit
        sadBtn.addTarget(self, action: #selector(sadBtnAction), for: .touchUpInside)

        itWasOkayBtn.setImage(UIImage(named: "itWasOkayIcon"), for: .normal)
        itWasOkayBtn.imageView?.contentMode = .scaleAspectFit
        itWasOkayBtn.addTarget(self, action: #selector(itWasOkayBtnAction), for: .touchUpInside)
        
        thinkingBtn.setImage(UIImage(named: "ThinkingIcon"), for: .normal)
        thinkingBtn.imageView?.contentMode = .scaleAspectFit
        thinkingBtn.addTarget(self, action: #selector(thinkingBtnAction), for: .touchUpInside)
        
        angryBtn.setImage(UIImage(named: "AngryIcon"), for: .normal)
        angryBtn.imageView?.contentMode = .scaleAspectFit
        angryBtn.addTarget(self, action: #selector(angryBtnAction), for: .touchUpInside)
 
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
    
    // emotion 관련 button
    @objc func heartEyesBtnAction() {
        if emotionSelectedNumber != 1 {
            for icon in [sadBtn, itWasOkayBtn, thinkingBtn, angryBtn] {
                icon.isEnabled = false
            }
            emotionSelectedNumber = 1
        } else {
            for icon in [sadBtn, itWasOkayBtn, thinkingBtn, angryBtn] {
                icon.isEnabled = true
            }
            emotionSelectedNumber = 0
        }
    }
    
    @objc func sadBtnAction() {
        if emotionSelectedNumber != 2 {
            for icon in [heartEyesBtn, itWasOkayBtn, thinkingBtn, angryBtn] {
                icon.isEnabled = false
            }
            emotionSelectedNumber = 2
        } else {
            for icon in [heartEyesBtn, itWasOkayBtn, thinkingBtn, angryBtn] {
                icon.isEnabled = true
            }
            emotionSelectedNumber = 0
        }
    }
    
    @objc func itWasOkayBtnAction() {
        if emotionSelectedNumber != 3 {
            for icon in [heartEyesBtn, sadBtn, thinkingBtn, angryBtn] {
                icon.isEnabled = false
            }
            emotionSelectedNumber = 3
        } else {
            for icon in [heartEyesBtn, sadBtn, thinkingBtn, angryBtn] {
                icon.isEnabled = true
            }
            emotionSelectedNumber = 0
        }
    }
    
    @objc func thinkingBtnAction() {
        if emotionSelectedNumber != 4 {
            for icon in [heartEyesBtn, sadBtn, itWasOkayBtn, angryBtn] {
                icon.isEnabled = false
            }
            emotionSelectedNumber = 4
        } else {
            for icon in [heartEyesBtn, sadBtn, itWasOkayBtn, angryBtn] {
                icon.isEnabled = true
            }
            emotionSelectedNumber = 0
        }
    }
    
    @objc func angryBtnAction() {
        if emotionSelectedNumber != 5 {
            for icon in [heartEyesBtn, sadBtn, itWasOkayBtn, thinkingBtn] {
                icon.isEnabled = false
            }
            emotionSelectedNumber = 5
        } else {
            for icon in [heartEyesBtn, sadBtn, itWasOkayBtn, thinkingBtn] {
                icon.isEnabled = true
            }
            emotionSelectedNumber = 0
        }
    }
    
    // 갤러리에서 이미지 불러오기
    @objc func addBtnAction() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        print("imagePicker 버튼 눌림")
        
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("이미지 선택")
        picker.dismiss(animated: true) { () in
            let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.selectedImages.image = img
            self.selectedImages.backgroundColor = .lightGray
            
            if let imageData = img?.pngData() {
                self.imageList.append(imageData)
            }
        }
    }

    // 저장 버튼 누르기
    @objc func doneButtonAction() {
        let content = textView.text
        let userId = UUID() as NSUUID
        let postId = UUID() as NSUUID
        saveData(userId, postId, emotionSelectedNumber, content ?? "", imageList)
        self.dismiss(animated: true)
    }
    
    // 취소 버튼 누르기
    @objc func cancelButtonAction() {
        self.dismiss(animated: true)
    }
    
    func saveData(_ postId: NSUUID, _ userId: NSUUID, _ emotionSelectedNumber: Int, _ content: String, _ imageList: [Data]) {
        CoreDataManager.shared.saveData(
            postId: postId,
            userId: userId,
            emotionSelectedNumber: emotionSelectedNumber,
            content: content,
            imageList: imageList
        )
        
        fetchPosts()
        print("저장 완료됐습니다")
    }
    
    func fetchPosts() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let fetchedPosts = try context.fetch(fetchRequest)
            for post in fetchedPosts {
                let postId = post.post_id
                let userId = post.user_id
                let emotion = post.emotion_num
                let content = post.post_text
                
                print("Post ID: \(postId), User ID: \(userId), Emotion: \(emotion), Content: \(content)")
            }
        } catch {
            print(error.localizedDescription)
        }
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
