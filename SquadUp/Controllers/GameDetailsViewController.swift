//
//  GameDetailsViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/5/20.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var playerCount: UILabel!
    @IBOutlet weak var listingCountTotal: UILabel!
    @IBOutlet weak var openListingsCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var createListingButton: UIButton!
    @IBOutlet weak var gameName: UILabel!
    
    var selectedGame: GameResponse.Game?
    var networkClient = NetworkingClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = selectedGame?._id else {return}
        print ("ID IS HERE", id)
        networkClient.fetchListings(gameId: id) { response, error in
            if let response = response {
                print("RESPONDER: \(response)")
            } else {
                print(error)
            }
        }
        favoriteButton.layer.cornerRadius = favoriteButton.frame.size.height/2
        createListingButton.layer.cornerRadius = createListingButton.frame.size.height/2
        gameName.text = selectedGame?.name
        }
    }
    


