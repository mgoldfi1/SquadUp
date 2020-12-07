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
    
    struct Listing: Codable {
        var viewCount: Int
        var active: Bool
        var _id: String
        var title: String
        var author: Author
        var game: Game
        var summary: String
        var seekingCount: Int
        var experienceLevel: String
        var createdAt: String
        var updatedAt: String
        
        struct Author: Codable {
            var _id: String
            var email: String
        }
        
        struct Game: Codable {
            var _id: String
            var name: String
        }
    }
}
