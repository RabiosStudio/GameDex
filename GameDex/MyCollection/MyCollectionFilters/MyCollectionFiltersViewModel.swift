//
//  MyCollectionFiltersViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/05/2024.
//

import Foundation
import UIKit

final class MyCollectionFiltersViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.filters
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let games: [SavedGame]
    
    init(games: [SavedGame]) {
        self.games = games
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [MyCollectionFiltersSection(
            games: self.games,
            editDelegate: self
        )]
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .close:
            self.close()
        default:
            break
        }
    }
    
    func configureBottomView(shouldEnableButton: Bool) {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.apply,
            shouldEnable: shouldEnableButton,
            position: .bottom
        )
        self.containerDelegate?.configureSupplementaryView(contentViewFactory: buttonContentViewFactory)
    }
    
    private func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
}

extension MyCollectionFiltersViewModel: EditFormDelegate {
    func enableSaveButtonIfNeeded() {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any FormCellViewModel)
              }) as? [any FormCellViewModel] else {
            return
        }
        
        let values: [Any?] = formCellsVM.map { $0.value }
        
        var shouldEnableButton = false
        for index in 0..<values.count {
            let currentValue = values[index]
            
            if currentValue != nil,
               let currentStringValue = currentValue as? String {
                shouldEnableButton = currentStringValue != ""
            }
            if shouldEnableButton {
                break
            }
        }
        self.configureBottomView(shouldEnableButton: shouldEnableButton)
    }
}

// MARK: - PrimaryButtonDelegate

extension MyCollectionFiltersViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        self.close()
    }
}
