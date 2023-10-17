//
//  MyCollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

// sourcery: AutoMockable
protocol MyCollectionViewModelDelegate: AnyObject {
    func reloadCollection() async
}

final class MyCollectionViewModel: ConnectivityDisplayerViewModel {
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
    private let cloudDatabase: CloudDatabase
    let authenticationService: AuthenticationService
    let connectivityChecker: ConnectivityChecker
    
    init(
        localDatabase: LocalDatabase,
        cloudDatabase: CloudDatabase,
        authenticationService: AuthenticationService,
        connectivityChecker: ConnectivityChecker
    ) {
        self.localDatabase = localDatabase
        self.cloudDatabase = cloudDatabase
        self.authenticationService = authenticationService
        self.connectivityChecker = connectivityChecker
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) async {
        self.displayInfoWarningIfNeeded()
        guard let userId = self.authenticationService.getUserId(),
              self.connectivityChecker.hasConnectivity() else {
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
            return
        }
        let fetchPlatformsResult = await self.cloudDatabase.getUserCollection(userId: userId)
        switch fetchPlatformsResult {
        case .success(let result):
            guard !result.isEmpty else {
                self.platforms = []
                self.sections = []
                let error: MyCollectionError = .emptyCollection(myCollectionDelegate: self)
                callback(error)
                return
            }
            self.platforms = result
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
}

// MARK: - AddGameDetailsViewModelDelegate

extension MyCollectionViewModel: MyCollectionViewModelDelegate {
    func reloadCollection() {
        self.containerDelegate?.reloadSections()
    }
}

extension MyCollectionViewModel: SearchViewModelDelegate {
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
