//
//  MyCollectionByPlatformsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionByPlatformsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem?
    let screenTitle: String?
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let gamesCollection: [SavedGame]
    
    init(gamesCollection: [SavedGame]) {
        self.gamesCollection = gamesCollection
        self.screenTitle = self.gamesCollection.first?.game.platform
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        guard !self.gamesCollection.isEmpty else {
            self.containerDelegate?.goBackToRootViewController()
            return
        }
        self.sections = [MyCollectionByPlatformsSection(gamesCollection: self.gamesCollection)]
        callback(nil)
    }
    
    func didTapRightButtonItem() {}
}
