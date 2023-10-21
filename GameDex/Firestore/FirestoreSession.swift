//
//  FirestoreSession.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 19/10/2023.
//

import Foundation
import FirebaseFirestore

protocol FirestoreSession {
    func getData(mainPath: String) async -> Result<[FirestoreData], DatabaseError>
    func getSingleData(path: String, directory: String) async -> Result<FirestoreData, DatabaseError>
    func setData(path: String, firestoreData: FirestoreData) async -> DatabaseError?
    func deleteData(path: String, directory: String) async -> DatabaseError? 
}
