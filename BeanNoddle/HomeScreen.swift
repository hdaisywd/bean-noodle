import UIKit

class HomeScreen: UIViewController {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    var Search: [Feed] = [] // Replace 'Feed' with your actual movie data structure
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadMovies()
    }
}

// MARK: - Collection View Configuration
extension HomeScreen {
    func configureCollectionView() {
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: "MainCell")
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
        return Search.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UICollectionViewCell()
        }
        
        let countFeed = Search[indexPath.item]
        cell.configure(with: countFeed)
        
        return cell
    }
}

// MARK: - Data Loading
extension HomeScreen {
    func loadMovies() {
        // Load your movie data and populate the 'movies' array
        // movies = ...
        
        collectionView.reloadData()
    }
}

// ... Add more extensions or methods as needed ...
