//
//  GameResponse.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/3/20.
//

import Foundation



struct GameResponse: Codable {
    var status: String
    var games: [Game]
    
    struct Game: Codable {
        var _id: String
        var createdAt: String
        var image: String
        var name: String
        var updatedAt: String
        var listingCount: ListingCount
        var playerCount: Int
        
        struct ListingCount: Codable {
            var open: Int
            var closed: Int
        }
    }
}
