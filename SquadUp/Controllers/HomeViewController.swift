//
//  HomeViewController.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/30/20.
//

import UIKit

class HomeViewController: UIViewController {

    var networkingClient = NetworkingClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingClient.fetchGames { response, error in
            if let error = error {
                //Update UI to reflect error
            } else if let response = response {
              //Set UICollectionView variable
            }
        }
    }
    

   

}

extension HomeViewController {
    
    
    
}
