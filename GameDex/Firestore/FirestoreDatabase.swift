//
//  FirestoreDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/09/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreDatabase: CloudDatabase {
    
    private enum Collections {
        case searchPlatform
        var path: String {
            switch self {
            case .searchPlatform:
                return "platforms"
            }
        }
    }
    
    private enum Attributes: String {
        case id
    }
    private let database = Firestore.firestore()
    
    func getAvailablePlatforms() async throws -> [Platform]? {
        let fetchedData = try await self.database.collection(Collections.searchPlatform.path).getDocuments()
        
        var platforms = [Platform]()
        for item in fetchedData.documents {
            let data = item.data()
            let title = item.documentID
            guard let id = data[Attributes.id.rawValue] as? Int else {
                return nil
            }
            let platform = Platform(
                title: title,
                id: id,
                games: nil
            )
            platforms.append(platform)
        }
        return platforms
    }
}
