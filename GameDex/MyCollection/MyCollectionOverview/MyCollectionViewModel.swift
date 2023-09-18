//
//  MyCollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

final class MyCollectionViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchCollection,
        activateOnTap: true,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: [AnyBarButtonItem]? = [.add, .search]
    let screenTitle: String? = L10n.myCollection
    var sections: [Section] = []
    var collection: [SavedGame] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let localDatabase: Database
    private let alertDisplayer: AlertDisplayer
    
    init(localDatabase: Database, alertDisplayer: AlertDisplayer) {
        self.localDatabase = localDatabase
        self.alertDisplayer = alertDisplayer
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let fetchCollectionResult = self.localDatabase.fetchAll()
        switch fetchCollectionResult {
        case .success(let result):
            guard !result.isEmpty else {
                let error: MyCollectionError = .emptyCollection(addGameDelegate: self)
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
    
    private func updateListOfCollections(with list: [SavedGame]) {
        self.sections = [MyCollectionSection(gamesCollection: list)]
    }
}

// MARK: - AddGameDetailsViewModelDelegate

extension MyCollectionViewModel: AddGameDetailsViewModelDelegate {
    func didAddNewGame() {
        self.containerDelegate?.reloadSections()
    }
}

extension MyCollectionViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text != "" else {
            self.updateListOfCollections(with: self.collection)
            callback(nil)
            return
        }
        let matchingCollections = self.collection.filter({
            $0.game.platform.title.localizedCaseInsensitiveContains(text)
        })
        self.updateListOfCollections(with: matchingCollections)
        
        if matchingCollections.isEmpty {
            callback(MyCollectionError.noItems)
        } else {
            callback(nil)
        }
    }
}
