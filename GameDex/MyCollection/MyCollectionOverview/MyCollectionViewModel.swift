//
//  MyCollectionViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol MyCollectionViewModelDelegate: AnyObject {
    func reloadCollection() async
    func apply(filters: [any Filter]) async
}

final class MyCollectionViewModel: ConnectivityDisplayerViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchCollection,
        activateOnTap: true,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.add]
    let screenTitle: String? = L10n.myCollection
    var sections: [Section] = []
    var platforms: [Platform] = []
    var layoutMargins: UIEdgeInsets? = UIEdgeInsets(
        top: .zero,
        left: DesignSystem.paddingRegular,
        bottom: DesignSystem.paddingRegular,
        right: DesignSystem.paddingRegular
    )
    
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
            let platformsFetched = self.localDatabase.fetchAllPlatforms()
            switch platformsFetched {
            case .success(let platforms):
                guard let emptyError = self.handleDataSuccess(platforms: CoreDataConverter.convert(platformsCollected: platforms)) else {
                    callback(nil)
                    return
                }
                callback(emptyError)
            case .failure:
                callback(MyCollectionError.fetchError)
            }
            return
        }
        let platformsFetched = await self.cloudDatabase.getUserCollection(userId: userId)
        switch platformsFetched {
        case .success(let platforms):
            guard let emptyError = self.handleDataSuccess(platforms: platforms) else {
                callback(nil)
                return
            }
            callback(emptyError)
        case .failure:
            callback(MyCollectionError.fetchError)
        }
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        self.presentAddGameMethods()
    }
}

extension MyCollectionViewModel {
    private func presentAddGameMethods() {
        Routing.shared.route(
            navigationStyle: .present(
                screenFactory: SelectPlatformScreenFactory(
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
    
    private func handleSectionCreation() {
        guard !self.platforms.isEmpty else {
            self.sections = []
            return
        }
        self.sections = [
            MyCollectionSection(
                platforms: self.platforms,
                myCollectionDelegate: self
            )
        ]
    }
    
    private func handleDataSuccess(platforms: [Platform]) -> EmptyError? {
        guard !platforms.isEmpty else {
            self.platforms = []
            self.handleFetchEmptyCollection()
            return MyCollectionError.emptyCollection(myCollectionDelegate: self)
        }
        self.platforms = platforms
        self.handleSectionCreation()
        return nil
    }
    
    private func handleFetchEmptyCollection() {
        self.handleSectionCreation()
    }
}

// MARK: - MyCollectionViewModelDelegate
extension MyCollectionViewModel: MyCollectionViewModelDelegate {
    func apply(filters: [any Filter]) async {}
    
    func reloadCollection() {
        self.containerDelegate?.reloadData()
    }
}

// MARK: - SearchViewModelDelegate
extension MyCollectionViewModel: SearchViewModelDelegate {
    func cancelButtonTapped(callback: @escaping (EmptyError?) -> ()) {
        self.updateListOfCollections(with: self.platforms)
        callback(nil)
    }
    
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ()) {
        guard text != "" else {
            self.updateListOfCollections(with: self.platforms)
            callback(nil)
            return
        }
        self.containerDelegate?.reloadNavBar()
        
        var matchingCollections = [Platform]()
        
        for platform in self.platforms {
            guard let _ = platform.supportedNames.first(where: { name in
                name.removeWhiteSpaces().lowercased().contains(
                    text.removeWhiteSpaces().lowercased()
                )
            }) else {
                continue
            }
            matchingCollections.append(platform)
        }
        
        self.updateListOfCollections(with: matchingCollections)
        
        if matchingCollections.isEmpty {
            callback(MyCollectionError.noItems)
        } else {
            callback(nil)
        }
    }
}
