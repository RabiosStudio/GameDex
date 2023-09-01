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
            if let error = await self.requestData() {
                callback(error)
            } else {
                self.platformsDisplayed.sort {
                    $0.title < $1.title
                }
                self.sections = [SelectPlatformSection(platforms: self.platformsDisplayed)]
                callback(nil)
            }
        }
    }
    
    private func requestData() async -> AddGameError? {
        // get data
        let result: Result<SearchPlatformsData, APIError> = await self.networkingSession.getData(with: GetPlatformsEndpoint(offset: self.platformsDisplayed.count))
        
        // check result
        switch result {
        case .success(let data):
            let platforms = DataConverter.convert(remotePlatforms: data.results)
            // store result data
            self.platformsDisplayed += platforms
            // if there is still data on other pages, we do the request again
            if self.platformsDisplayed.count < data.numberOfTotalResults {
                _ = await self.requestData()
            } else {
                return nil
            }
        case .failure(_):
            let error: AddGameError = .server
            return error
        }
        return nil
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
