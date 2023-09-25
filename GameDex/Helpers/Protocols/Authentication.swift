//
//  Authentication.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation

protocol AuthenticationService {
    func login(email: String, password: String, callback: @escaping (AuthenticationError?) -> ())
    func createUser(email: String, password: String, callback: @escaping (AuthenticationError?) -> ())
}
