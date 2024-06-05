//
//  SearchGameByTitleViewModel.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
import UIKit

final class SearchGameByTitleViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchGame,
        alwaysShow: true,
        activateOnTap: false,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.searchGame
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets? = UIEdgeInsets(
        top: .zero,
        left: DesignSystem.paddingRegular,
        bottom: DesignSystem.paddingRegular,
        right: DesignSystem.paddingRegular
    )
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let platform: Platform
    private var gamesQuery: [Game] = []
    
    private let networkingSession: API
    
    init(
        networkingSession: API,
        platform: Platform,
        progress: Float,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.progress = progress
        self.networkingSession = networkingSession
        self.platform = platform
        self.myCollectionDelegate = myCollectionDelegate
        self.sections = [
            SearchGameByTitleSection(
                gamesQuery: gamesQuery,
                platform: self.platform,
                myCollectionDelegate: myCollectionDelegate
            )
        ]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        callback(AddGameError.noSearch(platformName: self.platform.title))
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .close:
            self.close()
        default:
            break
        }
    }
    
    private func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
}

extension SearchGameByTitleViewModel: SearchViewModelDelegate {
    func cancelButtonTapped(callback: @escaping ((any EmptyError)?) -> ()) {
        self.sections = []
        self.containerDelegate?.reloadSections(emptyError: nil)
        callback(AddGameError.noSearch(platformName: self.platform.title))
    }
    
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        Task {
            let endpoint = GetGamesEndpoint(platformId: self.platform.id, title: searchQuery)
            
            await self.networkingSession.setCommonParameters(
                cloudDatabase: FirestoreDatabase()
            )
            let result: Result<SearchGamesData, APIError> = await self.networkingSession.getData(with: endpoint)
            
            switch result {
            case let .success(data):
                let games = RemoteDataConverter.convert(remoteGames: data.results, platform: self.platform).filter({ $0.releaseDate != nil })
                guard !games.isEmpty else {
                    callback(AddGameError.noItems)
                    return
                }
                self.gamesQuery = games
                self.sections = [SearchGameByTitleSection(
                    gamesQuery: self.gamesQuery,
                    platform: self.platform,
                    myCollectionDelegate: self.myCollectionDelegate
                )]
                callback(nil)
            case .failure(_):
                callback(AddGameError.server)
            }
        }
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
}
