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
        case users
        
        var path: String {
            switch self {
            case .searchPlatform:
                return "platforms"
            case .users:
                return "users"
            }
        }
    }
    
    private enum Attributes: String {
        case id
        case email
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
    
    func saveUser(userEmail: String, callback: @escaping (DatabaseError?) -> ()) {
        self.database.collection(Collections.users.path).document(userEmail).setData([
            Attributes.email.rawValue: userEmail.lowercased()
        ]) { error in
            if error != nil {
                callback(DatabaseError.saveError)
            } else {
                callback(nil)
            }
        }
    }
}
