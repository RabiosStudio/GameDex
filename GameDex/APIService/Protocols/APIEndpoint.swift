//
//  APIEndpoint.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

public protocol APIEndpoint {
    var path: String { get }
    var method: APIMethod { get }
    var entryParameters: [String: Any]? { get }
    func errorMessage(statusCode: Int) -> String
}
