//
//  SelectPlatformViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

final class SelectPlatformViewModel: CollectionViewModel {
    lazy var searchViewModel: SearchViewModel? = SearchViewModel(
        placeholder: L10n.searchPlatform,
        alwaysShow: true,
        activateOnTap: false,
        delegate: self
    )
    var isBounceable: Bool = true
    var isRefreshable: Bool = false
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.searchPlatform
    var sections = [Section]()
    private var platforms: [Platform] = []
    var layoutMargins: UIEdgeInsets? = UIEdgeInsets(
        top: .zero,
        left: DesignSystem.paddingRegular,
        bottom: DesignSystem.paddingRegular,
        right: DesignSystem.paddingRegular
    )
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let cloudDatabase: CloudDatabase
    
    init(
        cloudDatabase: CloudDatabase,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.progress = DesignSystem.oneThirdProgress
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
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .close:
            self.close()
        default:
            break
        }
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
        case let .success(platforms):
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
        
        var matchingPlatforms = [Platform]()
        
        for platform in self.platforms {
            guard let _ = platform.supportedNames.first(where: { name in
                name.removeWhiteSpaces().lowercased().contains(
                    text.removeWhiteSpaces().lowercased()
                )
            }) else {
                continue
            }
            matchingPlatforms.append(platform)
        }
        
        self.updateListOfPlatforms(with: matchingPlatforms)
        
        if matchingPlatforms.isEmpty {
            callback(AddGameError.noItems)
        } else {
            callback(nil)
        }
    }
}
