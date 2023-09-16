//
//  MyCollectionByPlatformsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import UIKit

final class MyCollectionByPlatformsViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchGame,
        activateOnTap: true,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: [AnyBarButtonItem]? = [.add, .search]
    let screenTitle: String?
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let gamesCollection: [SavedGame]
    
    init(gamesCollection: [SavedGame]) {
        self.gamesCollection = gamesCollection
        self.screenTitle = self.gamesCollection.first?.game.platform.title
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        guard !self.gamesCollection.isEmpty else {
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        self.sections = [MyCollectionByPlatformsSection(gamesCollection: self.gamesCollection)]
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        guard let platform = self.gamesCollection.first?.game.platform else {
            return
        }
        
        let containerController = SearchGameByTitleScreenFactory(
            platform: platform,
            addGameDelegate: self
        ).viewController
        
        let navigationController = UINavigationController(rootViewController: containerController)
        
        _ = Routing.shared.route(
            navigationStyle: .present(
                controller: navigationController,
                completionBlock: nil
            )
        )
    }
    
    private func updateListOfGames(with list: [SavedGame]) {
        self.sections = [MyCollectionByPlatformsSection(gamesCollection: list)]
    }
}

extension MyCollectionByPlatformsViewModel: AddGameDetailsViewModelDelegate {
    func didAddNewGame() {
        self.containerDelegate?.reloadSections()
    }
}

extension MyCollectionByPlatformsViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text != "" else {
            self.updateListOfGames(with: self.gamesCollection)
            callback(nil)
            return
        }
        let matchingGames = self.gamesCollection.filter({
            $0.game.title.localizedCaseInsensitiveContains(text)
        })
        self.updateListOfGames(with: matchingGames)
        
        if matchingGames.isEmpty {
            callback(MyCollectionError.noItems)
        } else {
            callback(nil)
        }
    }
}
