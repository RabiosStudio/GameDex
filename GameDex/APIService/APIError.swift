//
//  APIError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

public enum APIError: Error {
    case wrongUrl
    case server
    case parsingError
    case noData
}
