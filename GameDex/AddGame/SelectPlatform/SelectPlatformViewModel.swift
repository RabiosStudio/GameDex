//
//  SelectPlatformViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchPlatform,
        activateOnTap: false,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.searchPlatform
    var sections = [Section]()
    private var platforms: [Platform] = []
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    private let networkingSession: API
    
    init(networkingSession: API, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        self.progress = 1/3
        self.networkingSession = networkingSession
        self.gameDetailsDelegate = gameDetailsDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        Task {
            if let error = await self.requestData() {
                callback(error)
            } else {
                self.platforms.sort {
                    $0.title < $1.title
                }
                self.sections = [SelectPlatformSection(
                    platforms: self.platforms,
                    gameDetailsDelegate: self.gameDetailsDelegate
                )]
                callback(nil)
            }
        }
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
    
    private func requestData() async -> AddGameError? {
        // get data
        let result: Result<SearchPlatformsData, APIError> = await self.networkingSession.getData(with: GetPlatformsEndpoint(offset: self.platforms.count))
        
        // check result
        switch result {
        case .success(let data):
            let platforms = RemoteDataConverter.convert(remotePlatforms: data.results)
            // store result data
            self.platforms += platforms
            // if there is still data on other pages, we do the request again
            if self.platforms.count < data.numberOfTotalResults {
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
        self.sections = [SelectPlatformSection(
            platforms: list,
            gameDetailsDelegate: self.gameDetailsDelegate
        )]
    }
}

extension SelectPlatformViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text != "" else {
            self.updateListOfPlatforms(with: self.platforms)
            callback(nil)
            return
        }
        let matchingPlatforms = self.platforms.filter({
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
