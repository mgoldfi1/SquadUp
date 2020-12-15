//
//  HomeViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/30/20.
//

import UIKit

class HomeViewController: UIViewController {

    
    var networkingClient = NetworkingClient()
    var gamesArray = [GameResponse.Game]()
    var filteredGamesArray = [GameResponse.Game]()
    var selectedIndex: Int?
    
    let reuseIdentifier = "customCell"
    
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 2
        searchBar.layer.cornerRadius = 12
        if let textSearchField = searchBar.value(forKey: "searchField") as? UITextField {
                textSearchField.borderStyle = .roundedRect
                textSearchField.backgroundColor = .white
                textSearchField.textColor = .black
            }
        
        networkingClient.fetchGames { response, error in
           if let error = error {
              print("Error: \(error)")
           } else if let response = response {
            DispatchQueue.main.async {
                self.gamesArray = response
                self.filteredGamesArray = response
                self.collectionView.reloadData()
            }
           
               print("response: \(response)")

            }
        }
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 10.0
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 100, height: 100)
      }
        
        // MARK: - UICollectionViewDataSource protocol
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.filteredGamesArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
            let imageFileName = filteredGamesArray[indexPath.row].image
            let urlString = "http://localhost:8080/images/games/\(imageFileName)"

            let url = URL(string: urlString)
            if let imageData: NSData = NSData(contentsOf: url!) {
               cell.gameImage.image = UIImage(data: imageData as Data)
            }
            cell.backgroundColor = .white
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 12
            return cell
        }
        
        // MARK: - UICollectionViewDelegate protocol
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            print("You selected cell #\(indexPath.item)!")
            selectedIndex = indexPath.item
            self.performSegue(withIdentifier: "goToGameDetails", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! GameDetailsViewController
        if let indexPath = selectedIndex {
            destinationVC.selectedGame = filteredGamesArray[indexPath]
}
    }
    }
    

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText.isEmpty == false {
            filteredGamesArray = gamesArray.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
            collectionView.reloadData()
        } else {
            filteredGamesArray = gamesArray
            collectionView.reloadData()
        }
            
    }
    
}
    

