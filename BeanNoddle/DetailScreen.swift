//
//  DetailScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/15.
//

import Foundation
import UIKit

var images = ["01", "02", "03"]

class CustomCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
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
    
    var myCollectionView: UICollectionView!
    let pageControl = UIPageControl()

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
        stackView.spacing = 5
        
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
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width), height: (UIScreen.main.bounds.width))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        stackView.addArrangedSubview(myCollectionView)
        
        NSLayoutConstraint.activate([
            myCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            myCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.isPagingEnabled = true
        
        // 사진의 pagecontrol
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        stackView.addArrangedSubview(pageControl)
        
        // 세번째 구역
        let nicknameLabel2 = UILabel()
        nicknameLabel2.text = nickname
        nicknameLabel2.font = UIFont.boldSystemFont(ofSize: 26.0)
        stackView.addArrangedSubview(nicknameLabel2)
        
        // 다섯번째 구역
        let textView = UITextView()
        textView.text = "여행을 갔다왔다. 근데 여행을 또 가고 싶엇다. 헤헤. 음.. 나는 가고싶었던 곳이 과연어디인걸까? 생각을 한 번 해볼까? 아니.. 생각하기 싫다.. 응.. 생각하기 싫다.. 에휴... 벌써 새벽 3시다.. 세상에... "
        stackView.addArrangedSubview(textView)
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == myCollectionView {
            let pageWidth = scrollView.frame.size.width
            let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
            pageControl.currentPage = currentPage
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    

    
}
