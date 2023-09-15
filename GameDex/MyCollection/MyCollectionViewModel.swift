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
    var rightButtonItem: AnyBarButtonItem? = .add
    let screenTitle: String? = L10n.myCollection
    var sections: [Section] = []
    var collection: [SavedGame] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let localDatabase: LocalDatabase
    private let alertDisplayer: AlertDisplayer
    
    init(localDatabase: LocalDatabase, alertDisplayer: AlertDisplayer) {
        self.localDatabase = localDatabase
        self.alertDisplayer = alertDisplayer
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let fetchCollectionResult = self.localDatabase.fetchAll()
        switch fetchCollectionResult {
        case .success(let result):
            guard !result.isEmpty else {
                let error: MyCollectionError = .noItems(addGameDelegate: self)
                callback(error)
                return
            }
            self.collection = DataConverter.convert(gamesCollected: result)
            self.sections = [MyCollectionSection(gamesCollection: self.collection)]
            callback(nil)
        case .failure(_):
            let error: MyCollectionError = .fetchError
            callback(error)
        }
    }
    
    func didTapRightButtonItem() {
        _ = Routing.shared.route(
            navigationStyle: .present(
                controller: SelectAddGameMethodScreenFactory(
                    delegate: self
                ).viewController,
                completionBlock: nil)
        )
    }
}

// MARK: - AddGameDetailsViewModelDelegate

extension MyCollectionViewModel: AddGameDetailsViewModelDelegate {
    func didAddNewGame() {
        let fetchCollectionResult = self.localDatabase.fetchAll()
        switch fetchCollectionResult {
        case .success(let result):
            guard !result.isEmpty else {
                self.sections = []
                return
            }
            self.collection = DataConverter.convert(gamesCollected: result)
            self.sections = [MyCollectionSection(gamesCollection: self.collection)]
        case .failure(_):
            self.alertDisplayer.presentAlert(
                title: L10n.errorTitle,
                description: L10n.saveGameErrorTitle,
                type: .error
            )
        }
        self.containerDelegate?.reloadSections()
    }
}
