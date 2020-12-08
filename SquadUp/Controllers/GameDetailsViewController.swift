//
//  GameDetailsViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/5/20.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
//    @IBOutlet weak var playerCount: UILabel!
//    @IBOutlet weak var listingCountTotal: UILabel!
//    @IBOutlet weak var openListingsCount: UILabel!
//    @IBOutlet weak var favoriteButton: UIButton!
//    @IBOutlet weak var createListingButton: UIButton!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    
    
    var selectedGame: GameResponse.Game?
    var networkClient = NetworkingClient()
    var listings = [ListingResponse.Listing]()
    var sortedListings = [ListingResponse.Listing]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let id = selectedGame?._id else {return}
        networkClient.fetchListings(gameId: id) { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.listings = response
                    self.sortedListings = response
                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }
//        favoriteButton.layer.cornerRadius = favoriteButton.frame.size.height/2
//        createListingButton.layer.cornerRadius = createListingButton.frame.size.height/2
//        gameName.text = selectedGame?.name
        }
    }
    

extension GameDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT \(sortedListings.count)")
        return sortedListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! GameListingTableCell
        cell.listingTitle.text = sortedListings[indexPath.row].title.uppercased();       cell.listingSummary.text = sortedListings[indexPath.row].summary
        
        cell.layer.cornerRadius = 8
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        var formattedDate = dateFormatter.date(from: sortedListings[indexPath.row].createdAt)
            
        
        cell.listingDate.text = dateFormatter.string(from: formattedDate ?? Date())
        cell.listingAuthor.text  = "Posted by: \(sortedListings[indexPath.row].author.email)"
        cell.listingSeekingCount.text =
            "Seeking: \(String(sortedListings[indexPath.row].seekingCount))"
        
        return cell
        }
    
    
}
