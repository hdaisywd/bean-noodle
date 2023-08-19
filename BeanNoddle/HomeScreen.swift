import UIKit

@@ -8,9 +8,9 @@ class HomeScreen: UIViewController {
        cv.backgroundColor = .white
        return cv
    }()
    
    var Search: [Feed] = [] // Replace 'Feed' with your actual movie data structure
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
@@ -34,19 +34,19 @@ extension HomeScreen: UICollectionViewDelegateFlowLayout, UICollectionViewDataSo
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
@@ -56,9 +56,9 @@ extension HomeScreen {
    func loadMovies() {
        // Load your movie data and populate the 'movies' array
        // movies = ...
        
        collectionView.reloadData()
    }
}

// ... Add more extensions or methods as needed ...
