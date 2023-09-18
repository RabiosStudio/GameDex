//
//  SelectAddGameMethodViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectAddGameMethodViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = false
    var progress: Float?
    var rightButtonItem: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.addAGame
    var sections: [Section]
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    init(delegate: GameDetailsViewModelDelegate?) {
        self.sections = [SelectAddGameMethodSection(delegate: delegate)]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        _ = Routing.shared.route(navigationStyle: .dismiss(completionBlock: nil))
    }
}
