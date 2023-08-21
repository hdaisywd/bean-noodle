//
//  MyPageScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import Foundation
import UIKit

class MyPageScreen: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var PostCount: UILabel!
    @IBOutlet weak var FollowerCount: UILabel!
    @IBOutlet weak var FollowingCount: UILabel!
    
    @IBAction func profileEditButton(_ sender: UIButton) {
    }
    
    @IBAction func profileShare(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = 1
            let itemWidth = (collectionView.frame.width - spacing) / 2
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    func fetchPosts() {
        posts = UserDataManager.shared.fetchPosts(globalUserId as NSUUID)
    }
    
}

extension MyPageScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView 작동")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        if indexPath.item < posts.count {
            let imagesId = PictureDataManager.shared.fetchPicture(posts[indexPath.item].post_id! as NSUUID)
            if let thumbnailPicture = imagesId.first?.picture {
                // 옵셔널 바인딩을 통해 thumbnailPicture를 언래핑하고 UIImage로 변환
                if let image = UIImage(data: thumbnailPicture) {
                    cell.configure(with: image)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 1.0
        let height: CGFloat = width * 1.5
        return CGSize(width: width, height: height)
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!

    func configure(with image: UIImage) {
        print("configure 작동")
        cellImageView.image = image
    }
}

