import UIKit

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
    var currentPage = 1
    let refreshControl = UIRefreshControl()
    var isLoadingMore = false // 추가 데이터 로딩 중인지를 나타내는 플래그
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        view.backgroundColor = .white
        
        configureRefreshControl()
        configureCollectionView()
        loadInitialData() // 초기 데이터 로딩
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
    }
    
    @objc private func refreshMovies() {
        refreshFeed()
        loadMoreData() // 리프레시 이후에도 추가 데이터 로딩
    }
}

extension HomeScreen {
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.prefetchDataSource = self
    }
}

extension HomeScreen: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 1.0
        let height: CGFloat = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let feedItem = searchResults[indexPath.item]
        cell.configure(with: feedItem)
        return cell
    }
}

extension HomeScreen: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let maxIndex = indexPaths.map({ $0.item }).max(), maxIndex >= searchResults.count - 5 {
            loadMoreData() // 추가 데이터 로드
        }
    }
}

extension HomeScreen: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.height
        
        if offsetY > contentHeight - screenHeight {
            loadMoreData()
        }
    }
}

extension HomeScreen {
    
    private func loadInitialData() {
        isLoadingMore = true
            APIcaller.shared.getTrendingMovies(page: currentPage) { [weak self] result in
                switch result {
                case .success(let feeds):
                    self?.searchResults = feeds
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                        self?.isLoadingMore = false
                    }
                case .failure(let error):
                    print("Initial movie loading failed: \(error)")
                    self?.isLoadingMore = false
                }
            }
        }
    
    private func refreshFeed() {
        APIcaller.shared.getTrendingMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let newFeeds):
                self?.searchResults = newFeeds
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                print("Feed refresh failed: \(error)")
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func loadMoreData() {
        if isLoadingMore {
            return // 이미 추가 데이터 로딩 중인 경우 중복 호출 방지
        }
        isLoadingMore = true
        let nextPage = currentPage + 1
        APIcaller.shared.getTrendingMovies(page: nextPage) { [weak self] result in
            switch result {
            case .success(let newFeeds):
                self?.currentPage = nextPage
                self?.searchResults.append(contentsOf: newFeeds)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.isLoadingMore = false
                }
            case .failure(let error):
                print("Failed to load more data: \(error)")
                self?.isLoadingMore = false
            }
        }
    }
}
