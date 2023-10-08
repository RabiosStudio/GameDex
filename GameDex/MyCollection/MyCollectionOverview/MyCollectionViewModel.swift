//
//  MyCollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

// sourcery: AutoMockable
protocol MyCollectionViewModelDelegate: AnyObject {
    func reloadCollection()
}

final class MyCollectionViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchCollection,
        activateOnTap: true,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.add, .search]
    let screenTitle: String? = L10n.myCollection
    var sections: [Section] = []
    var platforms: [Platform] = []
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let localDatabase: LocalDatabase
    private let authenticationService: AuthenticationService
    private let connectionManager: ConnectionManager
    
    init(
        localDatabase: LocalDatabase,
        authenticationService: AuthenticationService,
        connectionManager: ConnectionManager
    ) {
        self.localDatabase = localDatabase
        self.authenticationService = authenticationService
        self.connectionManager = connectionManager
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.displayInfoWarningIfNeeded()
        let fetchPlatformsResult = self.localDatabase.fetchAllPlatforms()
        switch fetchPlatformsResult {
        case .success(let result):
            guard !result.isEmpty else {
                self.platforms = []
                self.sections = []
                let error: MyCollectionError = .emptyCollection(myCollectionDelegate: self)
                callback(error)
                return
            }
            self.platforms = CoreDataConverter.convert(platformsCollected: result)
            self.sections = [
                MyCollectionSection(
                    platforms: self.platforms,
                    myCollectionDelegate: self
                )
            ]
            callback(nil)
        case .failure(_):
            let error: MyCollectionError = .fetchError
            callback(error)
        }
    }
    
    func didTapRightButtonItem() {
        self.presentAddGameMethods()
    }
    
    private func presentAddGameMethods() {
        Routing.shared.route(
            navigationStyle: .present(
                screenFactory: SelectAddGameMethodScreenFactory(
                    delegate: self
                ),
                completionBlock: nil)
        )
    }
    
    private func updateListOfCollections(with list: [Platform]) {
        self.sections = [
            MyCollectionSection(
                platforms: list,
                myCollectionDelegate: self
            )
        ]
    }
    
    private func displayInfoWarningIfNeeded() {
        if !self.authenticationService.isUserLoggedIn() && self.connectionManager.hasConnectivity() {
            self.setupInfoWarning(text: L10n.infoLogout)
        } else if !self.connectionManager.hasConnectivity() {
            self.setupInfoWarning(text: L10n.infoNoInternet)
        }
    }
    
    private func setupInfoWarning(text: String) {
        self.containerDelegate?.configureSupplementaryView(
            contentViewFactory: InfoContentViewFactory(
                infoText: text,
                position: .top
            )
        )
    }
    
}

// MARK: - AddGameDetailsViewModelDelegate

extension MyCollectionViewModel: MyCollectionViewModelDelegate {
    func reloadCollection() {
        self.containerDelegate?.reloadSections()
    }
}

extension MyCollectionViewModel: SearchViewModelDelegate {
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text != "" else {
            self.updateListOfCollections(with: self.platforms)
            callback(nil)
            return
        }
        let matchingCollections = self.platforms.filter({
            $0.title.localizedCaseInsensitiveContains(text)
        })
        self.updateListOfCollections(with: matchingCollections)
        
        if matchingCollections.isEmpty {
            callback(MyCollectionError.noItems)
        } else {
            callback(nil)
        }
    }
}
