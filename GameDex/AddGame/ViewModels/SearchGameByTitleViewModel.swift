//
//  SearchGameByTitleViewModel.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

final class SearchGameByTitleViewModel: CollectionViewModel {
    lazy var searchViewModel = SearchViewModel(
        isSearchable: true,
        isActivated: true,
        placeholder: L10n.searchGame,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.searchGame
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let platform: Platform
    private var gamesQuery: [Game] = []
    
    var networkingSession: API
    
    init(networkingSession: API, platform: Platform) {
        self.progress = 2/3
        self.networkingSession = networkingSession
        self.platform = platform
        self.sections = [SearchGameByTitleSection(gamesQuery: gamesQuery, platform: self.platform)]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let error = AddGameError.noSearch
        callback(error)
    }
}

extension SearchGameByTitleViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        Task {
            let endpoint = GetGamesEndpoint(platformId: self.platform.id, title: searchQuery)
            
            // get response
            let result: Result<SearchGamesData, APIError> = await self.networkingSession.getData(with: endpoint)
            
            switch result {
            case .success(let data):
                let games = DataConverter.convert(remoteGames: data.results, platform: self.platform)
                self.gamesQuery = games
                DispatchQueue.main.async {
                    self.sections = [SearchGameByTitleSection(
                        gamesQuery: self.gamesQuery,
                        platform: self.platform
                    )]
                }
                callback(nil)
            case .failure(_):
                let error: AddGameError = .server
                callback(error)
            }
        }
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
}
