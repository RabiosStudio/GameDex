//
//  GetGamesEndpoint.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

class GetGamesEndpoint: APIEndpoint {
    // MARK: - Properties
    
    var path: String {
        return "games"
    }
    
    var url: URL {
        return URL(string: self.path)!
    }
    
    var method: APIMethod {
        return .get
    }
    
    var entryParameters: [String: Any]? {
        return ["platform": self.platformId, "title": self.title]
    }
    
    private let platformId: Int
    private let title: String
    
    init(platformId: Int, title: String) {
        self.platformId = platformId
        self.title = title
    }
}
