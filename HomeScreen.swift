import UIKit

class HomeScreen: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var searchResults: [Feed] = [] // Replace 'Feed' with your actual movie data structure
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        view.backgroundColor = .white
        
        configureCollectionView()
        loadMovies()
    }
}

// MARK: - Collection View Configuration
extension HomeScreen {
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Collection View Delegate & Data Source
extension HomeScreen: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
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

// MARK: - Data Loading
extension HomeScreen {
    func loadMovies() {
        APIcaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let feeds):
                self?.searchResults = feeds
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error loading movies: \(error)")
            }
        }
    }
}

// ... Add more extensions or methods as needed ...
