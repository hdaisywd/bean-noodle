import UIKit


// 스와이프 할때마다 사진 리로드
// 사진 클릭시 디테일뷰로 전환
// 디테일뷰에서 이미지 전달
class HomeScreen: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var searchResults: [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        view.backgroundColor = .white
        
        configureCollectionView()

        loadMovies() 
    }
}

extension HomeScreen {
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout 사용
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeScreen: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 1.0  // 가로 방향으로 3개의 아이템을 정렬
        let height: CGFloat = width * 1.5  // 이미지 비율에 맞게 높이 설정
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let feedItem = searchResults[indexPath.item]
        cell.configure(with: feedItem)  // 각 셀에 데이터를 적용하기 위한 메서드 호출
        return cell
    }
}

extension HomeScreen {
    func loadMovies() {
        APIcaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let feeds):
                self?.searchResults = feeds  // 데이터를 가져와서 검색 결과 배열에 할당
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()  // 데이터 로딩 후 컬렉션 뷰 리로딩
                }
            case .failure(let error):
                print("Error loading movies: \(error)")
            }
        }
    }
}
