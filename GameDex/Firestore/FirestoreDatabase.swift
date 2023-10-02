//
//  FirestoreDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/09/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreDatabase: CloudDatabase {
    
    private enum CollectionPaths: String {
        case platforms
    }
    
    private enum DocumentPaths: String {
        case id
    }
    private let database = Firestore.firestore()
    
    func getAvailablePlatforms() async throws -> [Platform]? {
        let fetchedData = try await database.collection(CollectionPaths.platforms.rawValue).getDocuments()
        
        var platforms = [Platform]()
        for item in fetchedData.documents {
            let data = item.data()
            let title = item.documentID
            guard let id = data[DocumentPaths.id.rawValue] as? Int else {
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
