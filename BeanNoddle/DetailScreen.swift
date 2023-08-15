//
//  DetailScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/15.
//

import Foundation
import UIKit

var images = ["HomeIcon", "tmpPic"]

class CustomCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.backgroundColor = .red

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error!")
    }
}


class DetailScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // title을 두 줄로 바꾸기
        let titleViewLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 100, 50))
        titleViewLabel.numberOfLines = 2
        titleViewLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleViewLabel.textAlignment = .center
        
        let nickname = "nickname"
        let posts = "Posts"
        let attributedText = NSMutableAttributedString(string: nickname + "\n" + posts)
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: nickname.count))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: nickname.count+1, length: posts.count))
        
        titleViewLabel.attributedText = attributedText
        self.navigationItem.titleView = titleViewLabel
        
        // Scroll View
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Stack View
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        // 첫번째 구역
        let topArea = UIStackView()
        stackView.addArrangedSubview(topArea)
        topArea.translatesAutoresizingMaskIntoConstraints = false
        topArea.axis = .horizontal
        topArea.distribution = .fillProportionally
        topArea.alignment = .fill
        topArea.spacing = 2
        
        let tmpImg = UIImage(named: "tmpPic")
        let tmpPic = UIImageView(image: tmpImg)
        tmpPic.contentMode = .scaleAspectFit
        topArea.addArrangedSubview(tmpPic)
        
        let nicknameLabel = UILabel()
        nicknameLabel.text = nickname
        nicknameLabel.textColor = .black
        topArea.addArrangedSubview(nicknameLabel)
        
        let moreIcon = UIImage(named: "moreIcon")
        let moreBtn = UIButton()
        moreBtn.setImage(moreIcon, for: .normal)
        topArea.addArrangedSubview(moreBtn)
        
        // 두번째 구역
        var myCollectionView: UICollectionView!
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        stackView.addArrangedSubview(myCollectionView)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        
        // 사진의 pagecontrol
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        stackView.addArrangedSubview(pageControl)
        
        
    }
    
    
    
}
