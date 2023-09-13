//
//  MyCollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

final class MyCollectionViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem?
    let screenTitle: String? = L10n.myCollection
    var sections: [Section] = []
    var collection: [SavedGame] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let localDatabase: LocalDatabase
    
    init(localDatabase: LocalDatabase) {
        self.localDatabase = localDatabase
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let fetchCollectionResult: Result<[SavedGame], DatabaseError> = self.localDatabase.fetchAll(
            databaseKey: DatabaseKey.savedGame
        )
        switch fetchCollectionResult {
        case .success(let result):
            guard !result.isEmpty else {
                let error: MyCollectionError = .noItems(addGameDelegate: self)
                callback(error)
                return
            }
            self.collection = result
            self.sections = [MyCollectionSection(gamesCollection: self.collection)]
        case .failure(_):
            let error: MyCollectionError = .fetchError
            callback(error)
        }
    }
}

// MARK: - AddGameDetailsViewModelDelegate

extension MyCollectionViewModel: AddGameDetailsViewModelDelegate {
    func didAddNewGame() {
        let fetchCollectionResult: Result<[SavedGame], DatabaseError> = self.localDatabase.fetchAll(
            databaseKey: DatabaseKey.savedGame
        )
        switch fetchCollectionResult {
        case .success(let result):
            guard !result.isEmpty else {
                self.sections = []
                return
            }
            self.collection = result
            self.sections = [MyCollectionSection(gamesCollection: self.collection)]
        case .failure(_):
            AlertService.shared.presentAlert(
                title: L10n.errorTitle,
                description: L10n.saveGameErrorTitle,
                type: .error
            )
        }
        self.containerDelegate?.reloadSections()
    }
}
