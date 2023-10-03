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
    
    private let database: LocalDatabase
    private let alertDisplayer: AlertDisplayer
    private var platform: Platform?
    
    init(
        platform: Platform?,
        database: LocalDatabase,
        alertDisplayer: AlertDisplayer,
        gameDetailsDelegate: GameDetailsViewModelDelegate?
    ) {
        self.platform = platform
        self.database = database
        self.alertDisplayer = alertDisplayer
        self.gameDetailsDelegate = gameDetailsDelegate
        self.screenTitle = self.platform?.title
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        guard let platform = self.platform,
              let games = platform.games else {
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        self.sections = [
            MyCollectionByPlatformsSection(
                games: games,
                platformName: platform.title,
                gameDetailsDelegate: gameDetailsDelegate
            )
        ]
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        self.startSearchingForGames()
    }
    
    private func startSearchingForGames() {
        guard let collection = self.platform else {
            return
        }
        
        Routing.shared.route(
            navigationStyle: .present(
                screenFactory: SearchGameByTitleScreenFactory(
                    platform: collection,
                    gameDetailsDelegate: self,
                    addToNavController: true
                ),
                completionBlock: nil
            )
        )
    }
    
    private func updateListOfGames(with list: [SavedGame]) {
        guard let platform = self.platform else { return }
        self.sections = [
            MyCollectionByPlatformsSection(
                games: list,
                platformName: platform.title,
                gameDetailsDelegate: gameDetailsDelegate
            )
        ]
    }
    
    private func displayAlert() {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .error,
                description: L10n.fetchGamesErrorDescription
            )
        )
    }
}

extension MyCollectionByPlatformsViewModel: GameDetailsViewModelDelegate {
    func reloadCollection() {
        guard let platformID = self.platform?.id else { return }
        let fetchCollectionResult = self.database.getPlatform(platformId: platformID)
        
        switch fetchCollectionResult {
        case .success(let result):
            guard let result else {
                self.displayAlert()
                return
            }
            
            let currentPlatform = CoreDataConverter.convert(platformCollected: result)
            
            guard let games = currentPlatform.games else {
                self.containerDelegate?.goBackToRootViewController()
                return
            }
            
            self.platform = currentPlatform
            self.sections = [
                MyCollectionByPlatformsSection(
                    games: games,
                    platformName: currentPlatform.title,
                    gameDetailsDelegate: gameDetailsDelegate
                )
            ]
            self.containerDelegate?.reloadSections()
        case .failure(_):
            self.displayAlert()
        }
    }
}

extension MyCollectionByPlatformsViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard let collection = self.platform,
              let games = collection.games else {
            callback(MyCollectionError.noItems)
            return
        }
        guard text != "" else {
            self.updateListOfGames(with: games)
            callback(nil)
            return
        }
        let matchingGames = games.filter({
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
