//
//  Networking.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/30/20.
//

import Foundation
import Alamofire

let defaults = UserDefaults.standard

protocol  NetworkingClientDelegate {
    func didSuccessfullyLogin(session: LoginSession)
    func loginFailed(session: LoginSession)
}

struct NetworkingClient {
 
    var delegate: NetworkingClientDelegate?
    
    let baseRestURL = "http://localhost:8080"
   
    func login(email: String, password: String) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        
       AF.request("\(baseRestURL)/auth/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: LoginSession.self) { response in
                if let auth = response.value {
                if let token = auth.token {
                    defaults.setValue(token, forKey: "accessToken")
                    self.delegate?.didSuccessfullyLogin(session: auth)
                } else if let message = auth.message {
                     self.delegate?.loginFailed(session: auth)
                }
            } else {
                let sessionError = LoginSession(token: nil, status: "Error", message: "Something went wrong")
                self.delegate?.loginFailed(session: sessionError)
            }
        }
        
    }
    
    
    func register(email: String, password: String) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request("\(baseRestURL)/auth/register", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: LoginSession.self) { response in
                 if let auth = response.value {
                 if let token = auth.token {
                     defaults.setValue(token, forKey: "accessToken")
                     self.delegate?.didSuccessfullyLogin(session: auth)
                 } else if let message = auth.message {
                      self.delegate?.loginFailed(session: auth)
                 }
             } else {
                 let sessionError = LoginSession(token: nil, status: "Error", message: "Something went wrong")
                 self.delegate?.loginFailed(session: sessionError)
             }
         }
        
    }
}


extension NetworkingClient {
    func fetchGames(action: @escaping ([GameResponse.Game]?, Bool? ) -> Void) {
        let token = defaults.string(forKey: "accessToken")

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
       
        AF.request("\(baseRestURL)/games/all",method: .get, headers: headers).responseDecodable(of: GameResponse.self) { response in
            guard let data = response.value else {
                print("error")
                return
            }
            
            if data.status == "OK" {
                action(data.games, nil)
            } else {
                action(nil, true)
            }
            
        }
    }
    
    
    func fetchListings(gameId: String, action: @escaping ([ListingResponse.Listing]?, Bool? ) -> Void) {
        let token = defaults.string(forKey: "accessToken")

        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let parameters: [String: String] = [
            "_id": gameId
        ]
        
        
        AF.request("\(baseRestURL)/games/listings",method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: ListingResponse.self) { response in
            
            print(response)
            guard let data = response.value else {
                print("error in guard let")
                return
            }
            
            if data.status == "OK" {
                action(data.listings, nil)
            } else {
                action(nil, true)
            }
            
        }
    }
    
    func favoriteRequest(gameId: String, action: @escaping (String?, Bool? ) -> Void) {
        let token = defaults.string(forKey: "accessToken")

        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(token!)"
        ]
        
        let parameters: [String: String] = [
            "_id": gameId
        ]
        
        
        AF.request("\(baseRestURL)/games/favoriteGame",method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: FavoriteResponse.self) { response in
            
            print(response)
            guard let data = response.value else {
                print("error in guard let")
                return
            }
            
            if data.status == "OK" {
                action(data.message, nil)
            } else {
                action(nil, true)
            }
            
        }
    }
}
