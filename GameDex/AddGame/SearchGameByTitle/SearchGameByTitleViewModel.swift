//
//  SearchGameByTitleViewModel.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

final class SearchGameByTitleViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchGame,
        activateOnTap: false,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.searchGame
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let platform: Platform
    private var gamesQuery: [Game] = []
    
    private let networkingSession: API
    
    init(
        networkingSession: API,
        platform: Platform,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.progress = 2/3
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
    
    func didTapRightButtonItem() {
        self.close()
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
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        Task {
            let endpoint = GetGamesEndpoint(platformId: self.platform.id, title: searchQuery)
            
            await self.networkingSession.setCommonParameters(
                cloudDatabase: FirestoreDatabase()
            )
            let result: Result<SearchGamesData, APIError> = await self.networkingSession.getData(with: endpoint)
            
            switch result {
            case .success(let data):
                guard !data.results.isEmpty else {
                    callback(AddGameError.noItems)
                    return
                }
                let games = RemoteDataConverter.convert(remoteGames: data.results, platform: self.platform)
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
