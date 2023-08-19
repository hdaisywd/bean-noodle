//
//  MyPageScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import Foundation
import UIKit

class MyPageScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var PostCount: UILabel!
    @IBOutlet weak var FollowerCount: UILabel!
    @IBOutlet weak var FollowingCount: UILabel!
    
    @IBOutlet weak var highlightCollectionView: UICollectionView!
    
    
    func collectionView(_ highlightCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
        
    }
    //다시 만들어야됨
    func collectionView(_ highlightCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = highlightCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightCollectionView.dataSource = self
        highlightCollectionView.delegate = self
        
        
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
}

