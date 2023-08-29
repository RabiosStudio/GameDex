//
//  SelectPlatformViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformViewModel: CollectionViewModel {
    lazy var searchViewModel = SearchViewModel(
        isSearchable: true,
        isActivated: true,
        placeholder: L10n.searchPlatform,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.selectPlatform
    var sections = [Section]()
    private var platformsDisplayed: [Platform] = []
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let networkingSession: API
    
    init(networkingSession: API) {
        self.progress = 1/3
        self.networkingSession = networkingSession
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        Task {
            let endpoint = GetPlatformsEndpoint()
            
            // get reponse
            let result: Result<SearchPlatformsData, APIError> = await self.networkingSession.getData(with: endpoint)
            
            switch result {
            case .success(let data):
                let platforms = DataConverter.convert(remotePlatforms: data.platforms)
                self.platformsDisplayed = platforms
                DispatchQueue.main.async {
                    self.sections = [SelectPlatformSection(platforms: platforms)]
                }
                callback(nil)
            case .failure(_):
                let error: AddGameError = .server
                callback(error)
            }
        }
    }
    
    private func updateListOfPlatforms(with list: [Platform]) {
        self.sections = [SelectPlatformSection(platforms: list)]
    }
}

extension SelectPlatformViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text.count > .zero else {
            self.updateListOfPlatforms(with: self.platformsDisplayed)
            return
        }
        
        let matchingPlatforms = self.platformsDisplayed.filter({
            $0.title.localizedCaseInsensitiveContains(text)
        })
        self.updateListOfPlatforms(with: matchingPlatforms)
        
        if matchingPlatforms.isEmpty {
            callback(AddGameError.noItems)
        } else {
            callback(nil)
        }
    }
}
