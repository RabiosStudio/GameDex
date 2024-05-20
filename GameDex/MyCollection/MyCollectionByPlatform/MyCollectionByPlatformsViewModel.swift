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
    var rightButtonItems: [AnyBarButtonItem]? = [.filter, .add]
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
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) async {
        self.displayInfoWarningIfNeeded()
        guard let platform = self.platform,
              let games = platform.games else {
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        self.sections = [
            MyCollectionByPlatformsSection(
                games: games,
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
        print("filter tapped")
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
}

extension MyCollectionByPlatformsViewModel: MyCollectionViewModelDelegate {
    func reloadCollection() async {
        guard let platform = self.platform else { return }
        guard let userId = self.authenticationService.getUserId(),
              self.connectivityChecker.hasConnectivity() else {
            
            let fetchCollectionResult = self.localDatabase.getPlatform(platformId: platform.id)
            switch fetchCollectionResult {
            case .success(let platform):
                guard let platform else {
                    await self.myCollectionDelegate?.reloadCollection()
                    self.containerDelegate?.reloadSections()
                    return
                }
                
                let currentPlatform = CoreDataConverter.convert(platformCollected: platform)
                
                guard let games = currentPlatform.games else {
                    await self.myCollectionDelegate?.reloadCollection()
                    self.containerDelegate?.goBackToRootViewController()
                    return
                }
                
                self.platform = currentPlatform
                self.sections = [
                    MyCollectionByPlatformsSection(
                        games: games,
                        platform: currentPlatform,
                        myCollectionDelegate: self
                    )
                ]
                await self.myCollectionDelegate?.reloadCollection()
                self.containerDelegate?.reloadSections()
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
        case .success(let platform):
            guard let games = platform.games else {
                await self.myCollectionDelegate?.reloadCollection()
                self.containerDelegate?.reloadSections()
                return
            }
            self.platform = platform
            self.sections = [
                MyCollectionByPlatformsSection(
                    games: games,
                    platform: platform,
                    myCollectionDelegate: self
                )
            ]
            await self.myCollectionDelegate?.reloadCollection()
            self.containerDelegate?.reloadSections()
        case .failure(_):
            self.displayAlert()
        }
        self.displayInfoWarningIfNeeded()
    }
}

extension MyCollectionByPlatformsViewModel: SearchViewModelDelegate {
    func cancelButtonTapped(callback: @escaping (EmptyError?) -> ()) {
        guard let collection = self.platform,
              let games = collection.games else {
            callback(MyCollectionError.noItems)
            return
        }
        self.updateListOfGames(with: games)
        self.rightButtonItems = [.filter, .add]
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
        self.containerDelegate?.reloadNavBar()
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
