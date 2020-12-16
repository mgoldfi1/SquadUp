//
//  ListingResponse.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/7/20.
//

import Foundation


struct ListingResponse: Codable {
    var status: String
    var listings: [Listing]
    
}
