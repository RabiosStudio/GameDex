//
//  MyCollectionByPlatformsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation
import UIKit

final class MyCollectionByPlatformsViewModel: ConnectivityDisplayerViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchGame,
        activateOnTap: true,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]?
    let screenTitle: String?
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets? = UIEdgeInsets(
        top: .zero,
        left: DesignSystem.paddingRegular,
        bottom: DesignSystem.paddingRegular,
        right: DesignSystem.paddingRegular
    )
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let localDatabase: LocalDatabase
    private let cloudDatabase: CloudDatabase
    private let alertDisplayer: AlertDisplayer
    private var platform: Platform?
    private var displayedGames: [SavedGame]
    private var selectedFilters: [GameFilter]?
    let authenticationService: AuthenticationService
    let connectivityChecker: ConnectivityChecker
    
    init(
        platform: Platform?,
        localDatabase: LocalDatabase,
        cloudDatabase: CloudDatabase,
        alertDisplayer: AlertDisplayer,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        authenticationService: AuthenticationService,
        connectivityChecker: ConnectivityChecker
    ) {
        self.platform = platform
        self.localDatabase = localDatabase
        self.cloudDatabase = cloudDatabase
        self.alertDisplayer = alertDisplayer
        self.myCollectionDelegate = myCollectionDelegate
        self.authenticationService = authenticationService
        self.connectivityChecker = connectivityChecker
        self.screenTitle = self.platform?.title
        self.displayedGames = self.platform?.games ?? []
        self.selectedFilters = nil
        self.buttonItems = [.filter(active: false), .add]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) async {
        self.displayInfoWarningIfNeeded()
        guard let platform = self.platform,
              !self.displayedGames.isEmpty else {
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        
        self.sections = [
            MyCollectionByPlatformsSection(
                games: self.displayedGames,
                platform: platform,
                myCollectionDelegate: self
            )
        ]
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .add:
            self.startSearchingForGames()
        case .filter:
            self.openFilters()
        default:
            break
        }
    }
    
    private func startSearchingForGames() {
        guard let collection = self.platform else {
            return
        }
        
        Routing.shared.route(
            navigationStyle: .present(
                screenFactory: SearchGameByTitleScreenFactory(
                    platform: collection,
                    progress: DesignSystem.halfProgress,
                    myCollectionDelegate: self
                ),
                completionBlock: nil
            )
        )
    }
    
    private func openFilters() {
        guard let games = platform?.games else {
            return
        }
        Routing.shared.route(
            navigationStyle: .present(
                screenFactory: MyCollectionFiltersScreenFactory(
                    games: games,
                    selectedFilters: self.selectedFilters ?? nil,
                    myCollectionDelegate: self
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
                platform: platform,
                myCollectionDelegate: self
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
    
    private func handleReloadCollectionSuccess() async {
        await self.myCollectionDelegate?.reloadCollection()
        await self.apply(filters: self.selectedFilters ?? [])
    }
    
    private func handleReloadEmptyCollection() async {
        await self.myCollectionDelegate?.reloadCollection()
        self.containerDelegate?.goBackToRootViewController()
    }
}

extension MyCollectionByPlatformsViewModel: MyCollectionViewModelDelegate {
    func clearFilters() async {
        guard let games = self.platform?.games else {
            await self.reloadCollection()
            return
        }
        self.selectedFilters = nil
        self.updateListOfGames(with: games)
        self.displayedGames = games
        self.buttonItems = [.filter(active: false), .add]
        self.containerDelegate?.reloadNavBar()
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
    
    func apply(filters: [GameFilter]) async {
        guard let games = self.platform?.games,
              !filters.isEmpty else {
            await self.clearFilters()
            return
        }
        self.selectedFilters = filters
        var shouldKeepGame = false
        var filteredGames = [SavedGame]()
        for index in 0..<games.count {
            let currentGame = games[index]
            for filter in filters {
                shouldKeepGame = self.shouldDisplayGame(
                    game: currentGame,
                    filter: filter
                )
                if !shouldKeepGame {
                    break
                }
            }
            if shouldKeepGame {
                filteredGames.append(games[index])
            }
        }
        self.updateListOfGames(with: filteredGames)
        self.displayedGames = filteredGames
        self.buttonItems = [.filter(active: true), .add]
        self.containerDelegate?.reloadSections(
            emptyError: filteredGames.isEmpty ? MyCollectionError.noItems(delegate: self) : nil
        )
        self.containerDelegate?.reloadNavBar()
    }
    
    private func shouldDisplayGame(game: SavedGame, filter: GameFilter) -> Bool {
        var shouldDisplayGame: Bool = false
        if let gameData = game[keyPath: filter.keyPath] as? String,
           let filterStringValue: String = filter.value() {
            shouldDisplayGame = filterStringValue == gameData
        } else if let gameData = game[keyPath: filter.keyPath] as? Int,
                  let filterIntValue: Int = filter.value() {
            shouldDisplayGame = filterIntValue == gameData
        }
        return shouldDisplayGame
    }
    
    func reloadCollection() async {
        guard let platform = self.platform else { return }
        guard let userId = self.authenticationService.getUserId(),
              self.connectivityChecker.hasConnectivity() else {
            
            let fetchCollectionResult = self.localDatabase.getPlatform(platformId: platform.id)
            switch fetchCollectionResult {
            case let .success(platform):
                guard let platform else {
                    await self.handleReloadEmptyCollection()
                    return
                }
                
                let currentPlatform = CoreDataConverter.convert(platformCollected: platform)
                self.platform = currentPlatform
                
                guard let games = currentPlatform.games else {
                    await self.handleReloadEmptyCollection()
                    return
                }
                self.displayedGames = games
                await self.handleReloadCollectionSuccess()
            case .failure:
                self.displayAlert()
            }
            self.displayInfoWarningIfNeeded()
            return
        }
        
        let fetchPlatformsResult = await self.cloudDatabase.getSinglePlatformCollection(
            userId: userId,
            platform: platform
        )
        switch fetchPlatformsResult {
        case let .success(platform):
            guard let games = platform.games,
                  !games.isEmpty else {
                await self.handleReloadEmptyCollection()
                return
            }
            self.platform = platform
            self.displayedGames = games
            await self.handleReloadCollectionSuccess()
        case .failure(_):
            self.displayAlert()
        }
        self.displayInfoWarningIfNeeded()
    }
}

extension MyCollectionByPlatformsViewModel: SearchViewModelDelegate {
    func cancelButtonTapped(callback: @escaping (EmptyError?) -> ()) {
        self.updateListOfGames(with: self.displayedGames)
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard !self.displayedGames.isEmpty else {
            callback(MyCollectionError.noItems(delegate: self))
            return
        }
        guard text != "" else {
            self.updateListOfGames(with: self.displayedGames)
            callback(nil)
            return
        }
        let matchingGames = self.displayedGames.filter({
            $0.game.title.localizedCaseInsensitiveContains(text)
        })
        self.updateListOfGames(with: matchingGames)
        
        if matchingGames.isEmpty {
            callback(MyCollectionError.noItems(delegate: self))
        } else {
            callback(nil)
        }
    }
}
