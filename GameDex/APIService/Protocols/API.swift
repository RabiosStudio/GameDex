//
//  API.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation
import Alamofire

public protocol API {
    
    var lastTask: URLSessionTask? { get set }
    var basePath: String { get }
    
    func getData<T: APIEndpoint, U: Decodable>(
        with endpoint: T,
        resultType: U.Type
    ) async -> Result<U, APIError>
}
