//
//  GetGamesEndpoint.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

class GetGamesEndpoint: APIEndpoint {
    // MARK: - Properties
    
    private enum Constants {
        static let name = "name"
        static let platforms = "platforms"
        static let filter = "filter"
        static let format = "format"
        static let json = "json"
        static let fieldList = "field_list"
        static let requestedFields = "deck,guid,id,image,image_tags,name,number_of_user_reviews,original_game_rating,original_release_date,platforms,site_detail_url"
    }
    
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
        return [Constants.format: Constants.json,
                Constants.filter: "\(Constants.name):\(self.title),\(Constants.platforms):\(self.platformId)",
                Constants.fieldList: Constants.requestedFields]
    }
    
    private let platformId: Int
    private let title: String
    
    init(platformId: Int, title: String) {
        self.platformId = platformId
        self.title = title
    }
}
