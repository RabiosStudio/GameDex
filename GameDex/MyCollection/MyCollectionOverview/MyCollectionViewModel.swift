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
    var rightButtonItems: [AnyBarButtonItem]? = [.add, .search]
    let screenTitle: String? = L10n.myCollection
    var sections: [Section] = []
    var platforms: [Platform] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    private let localDatabase: Database
    private let alertDisplayer: AlertDisplayer
    
    init(localDatabase: Database, alertDisplayer: AlertDisplayer) {
        self.localDatabase = localDatabase
        self.alertDisplayer = alertDisplayer
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let fetchPlatformsResult = self.localDatabase.fetchAllPlatforms()
        switch fetchPlatformsResult {
        case .success(let result):
            guard !result.isEmpty else {
                self.platforms = []
                self.sections = []
                let error: MyCollectionError = .emptyCollection(gameDetailsDelegate: self)
                callback(error)
                return
            }
            self.platforms = CoreDataConverter.convert(platformsCollected: result)
            self.sections = [
                MyCollectionSection(
                    platforms: self.platforms,
                    gameDetailsDelegate: self
                )
            ]
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
    
    func didSelectItem(indexPath: IndexPath) {}
    
    private func updateListOfCollections(with list: [Platform]) {
        self.sections = [
            MyCollectionSection(
                platforms: list,
                gameDetailsDelegate: self
            )
        ]
    }
}

// MARK: - AddGameDetailsViewModelDelegate

extension MyCollectionViewModel: GameDetailsViewModelDelegate {
    func reloadCollection() {
        self.containerDelegate?.reloadSections()
    }
}

extension MyCollectionViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text != "" else {
            self.updateListOfCollections(with: self.platforms)
            callback(nil)
            return
        }
        let matchingCollections = self.platforms.filter({
            $0.title.localizedCaseInsensitiveContains(text)
        })
        self.updateListOfCollections(with: matchingCollections)
        
        if matchingCollections.isEmpty {
            callback(MyCollectionError.noItems)
        } else {
            callback(nil)
        }
    }
}
