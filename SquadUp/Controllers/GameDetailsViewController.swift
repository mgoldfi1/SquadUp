//
//  GameDetailsViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/5/20.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listingCountLabel: UILabel!
    @IBOutlet weak var playerCountLabel: UILabel!
    @IBOutlet weak var totalListingsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    
    
   
    var selectedGame: GameResponse.Game!
    var networkClient = NetworkingClient()
    var listings = [ListingResponse.Listing]()
    var sortedListings = [ListingResponse.Listing]()
    
    
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        if let game = selectedGame {
            networkClient.favoriteRequest(gameId: game._id) { response, error in
                if let response = response  {
                    if (response == "Added to favorites") {
                        self.favoriteButton.setTitle("Favorited", for: .normal)
                        self.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                        self.playerCountLabel.text = String("Players: \(self.selectedGame.playerCount + 1)")
                    } else if response == "Removed from favorites" {
                        self.favoriteButton.setTitle("Add to favorites", for: .normal)
                        self.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                        self.playerCountLabel.text = String("Players: \(self.selectedGame.playerCount)")

                    }
                }
            }
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
 
    
        
        favoriteButton.layer.cornerRadius = 12
        
        let imageFileName = selectedGame.image
        
        let urlString = "http://localhost:8080/images/games/\(imageFileName)"

        let url = URL(string: urlString)
        if let imageData: NSData = NSData(contentsOf: url!) {
            background.image = UIImage(data: imageData as Data)
        }
        
        
        let playerCount = selectedGame.playerCount
        let totalListingCount = (selectedGame.listingCount.closed) + (selectedGame.listingCount.open)
        
        gameName.text = selectedGame.name
        playerCountLabel.text = "Players: \(String(playerCount))"
        totalListingsLabel.text = "Total Listings: \(totalListingCount)"
        
        networkClient.fetchListings(gameId: selectedGame._id) { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.listings = response
                    self.sortedListings = response
                    self.listingCountLabel.text = "Open Listings: \(String(self.sortedListings.count))"
                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }

        }
    }
    

extension GameDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! GameListingTableCell
        
        cell.cellContainer.layer.cornerRadius = 8
        cell.listingTitle.text = sortedListings[indexPath.row].title.uppercased();       cell.listingSummary.text = sortedListings[indexPath.row].summary
        
        cell.selectionStyle = .none
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let formattedDate = dateFormatter.date(from: sortedListings[indexPath.row].createdAt)
            

        cell.listingDate.text = dateFormatter.string(from: formattedDate ?? Date())
        
        cell.listingAuthor.text  = "Posted by: \(sortedListings[indexPath.row].author.email)"
        
        cell.listingSeekingCount.text =
            "Seeking: \(String(sortedListings[indexPath.row].seekingCount))"
        
        return cell
        
        }
  
    
}
