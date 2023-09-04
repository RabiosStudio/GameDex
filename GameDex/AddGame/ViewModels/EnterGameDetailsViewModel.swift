//
//  EnterGameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class EnterGameDetailsViewModel: CollectionViewModel {
    lazy var searchViewModel = SearchViewModel(
        isSearchable: false,
        isActivated: false
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.fillGameDetails
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let game: Game
    
    init(game: Game) {
        self.progress = 3/3
        self.game = game
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [GamePreviewSection(game: self.game), GameFormBasicSection(), GameFormOtherDetailsSection()]
        callback(nil)
    }
}
