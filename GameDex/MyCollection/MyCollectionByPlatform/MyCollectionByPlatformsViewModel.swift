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
    var rightButtonItems: [AnyBarButtonItem]? = [.add, .search]
    let screenTitle: String?
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    private let database: Database
    private let alertDisplayer: AlertDisplayer
    private var gamesCollection: [SavedGame]
    
    init(
        gamesCollection: [SavedGame],
        database: Database,
        alertDisplayer: AlertDisplayer,
        gameDetailsDelegate: GameDetailsViewModelDelegate?
    ) {
        self.gamesCollection = gamesCollection
        self.database = database
        self.alertDisplayer = alertDisplayer
        self.gameDetailsDelegate = gameDetailsDelegate
        self.screenTitle = self.gamesCollection.first?.game.platform.title
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        guard !self.gamesCollection.isEmpty else {
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        self.sections = [
            MyCollectionByPlatformsSection(
                gamesCollection: self.gamesCollection,
                gameDetailsDelegate: gameDetailsDelegate
            )
        ]
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        guard let platform = self.gamesCollection.first?.game.platform else {
            return
        }
        
        let containerController = SearchGameByTitleScreenFactory(
            platform: platform,
            gameDetailsDelegate: self
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
        self.sections = [
            MyCollectionByPlatformsSection(
                gamesCollection: list,
                gameDetailsDelegate: gameDetailsDelegate
            )
        ]
    }
}

extension MyCollectionByPlatformsViewModel: GameDetailsViewModelDelegate {
    func reloadCollection() {
        let fetchCollectionResult = self.database.fetchAll()
        switch fetchCollectionResult {
        case .success(let result):
            guard !result.isEmpty else {
                self.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .error,
                        description: L10n.fetchGamesErrorDescription
                    )
                )
                return
            }
            
            let collection = DataConverter.convert(gamesCollected: result)
            
            var updatedGamesCollection = [SavedGame]()
            for item in collection where item.game.platform.id == self.gamesCollection.first?.game.platform.id {
                updatedGamesCollection.append(item)
            }
            
            self.gamesCollection = updatedGamesCollection
            self.sections = [
                MyCollectionByPlatformsSection(
                    gamesCollection: self.gamesCollection,
                    gameDetailsDelegate: gameDetailsDelegate
                )
            ]
            self.containerDelegate?.reloadSections()
        case .failure(_):
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: .error,
                    description: L10n.fetchGamesErrorDescription
                )
            )
        }
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
