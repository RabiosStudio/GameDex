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
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        let error = AddGameError.noSearch
        callback(error)
    }
}

extension SearchGameByTitleViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
                callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
}
