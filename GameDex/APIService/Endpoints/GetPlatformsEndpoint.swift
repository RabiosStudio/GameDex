//
//  GetPlatformsEndpoint.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 24/08/2023.
//

import Foundation

class GetPlatformsEndpoint: APIEndpoint {
    // MARK: - Properties
    
    private enum Constants {
        static let format = "format"
        static let json = "json"
        static let fieldList = "field_list"
        static let requestedFields = "id,name"
        static let offset = "offset"
    }
    
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
        return [Constants.format: Constants.json,
                Constants.fieldList: Constants.requestedFields,
                Constants.offset: self.offset]
    }
    
    private var offset: Int
    
    init(offset: Int) {
        self.offset = offset
    }
}
