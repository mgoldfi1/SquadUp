//
//  LoginSession.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/30/20.
//

import Foundation

struct LoginSession: Codable {
    
    var token: String?
    var status: String
    var message: String?
}
