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
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let cloudDatabase: CloudDatabase
    
    init(
        cloudDatabase: CloudDatabase,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.progress = 1/3
        self.cloudDatabase = cloudDatabase
        self.myCollectionDelegate = myCollectionDelegate
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
                    myCollectionDelegate: self.myCollectionDelegate
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
        let fetchedPlatformsResult = await self.cloudDatabase.getAvailablePlatforms()
        switch fetchedPlatformsResult {
        case .success(let platforms):
            self.platforms = platforms
            return nil
        case .failure(_):
            return AddGameError.server
        }
    }
    
    private func updateListOfPlatforms(with list: [Platform]) {
        self.sections = [SelectPlatformSection(
            platforms: list,
            myCollectionDelegate: self.myCollectionDelegate
        )]
    }
}

extension SelectPlatformViewModel: SearchViewModelDelegate {
    func cancelButtonTapped(callback: @escaping (EmptyError?) -> ()) {
        self.updateListOfPlatforms(with: self.platforms)
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
