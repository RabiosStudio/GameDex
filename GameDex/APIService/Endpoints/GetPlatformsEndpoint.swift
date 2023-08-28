//
//  GetPlatformsEndpoint.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

class GetPlatformsEndpoint: APIEndpoint {
    // MARK: - Properties    
    
    var path: String {
        return "platforms"
    }
    
    var url: URL {
        return URL(string: self.path)!
    }
    
    var method: APIMethod {
        return .get
    }
    
    var entryParameters: [String: Any]? {
        return nil
    }    
}
