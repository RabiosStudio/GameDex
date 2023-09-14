//
//  API.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

// sourcery: AutoMockable
protocol API {
    var lastTask: URLSessionTask? { get set }
    var basePath: String { get }
    var commonParameters: [String: Any]? { get }
    
    func getData<T: APIEndpoint, U: Decodable>(
        with endpoint: T
    ) async -> Result<U, APIError>
}
