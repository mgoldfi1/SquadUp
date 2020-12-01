//
//  Networking.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 11/30/20.
//

import Foundation
import Alamofire



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
