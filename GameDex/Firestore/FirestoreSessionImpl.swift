//
//  FirestoreSessionImpl.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 19/10/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreSessionImpl: FirestoreSession {
    private let database = Firestore.firestore()
    
    func getData(mainPath: String) async -> Result<[FirestoreData], DatabaseError> {
        do {
            let fetchedData = try await self.database.collection(mainPath).getDocuments()
            var firestoreData = [FirestoreData]()
            for item in fetchedData.documents {
                firestoreData.append(FirestoreData(id: item.documentID, data: item.data()))
            }
            return .success(firestoreData)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func getSingleData(path: String, directory: String) async -> Result<FirestoreData, DatabaseError> {
        do {
            let doc = self.database.collection(path).document(directory)
            let fetchedData = try await doc.getDocument()
            guard let data = fetchedData.data() else {
                return .failure(DatabaseError.fetchError)
            }
            let firestoreData = FirestoreData(id: fetchedData.documentID, data: data)
            return .success(firestoreData)
        } catch {
            return .failure(DatabaseError.fetchError)
        }
    }
    
    func setData(path: String, firestoreData: FirestoreData) async -> DatabaseError? {
        do {
            try await
            self.database.collection(path).document(firestoreData.id).setData(firestoreData.data)
            return nil
        } catch {
            return DatabaseError.saveError
        }
    }
    
    func deleteData(path: String, directory: String) async -> DatabaseError? {
        do {
            try await self.database.collection(path).document(directory).delete()
            return nil
        } catch {
            return DatabaseError.removeError
        }
    }
}
