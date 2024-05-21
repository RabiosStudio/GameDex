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
    var rightButtonItems: [AnyBarButtonItem]? = [.close, .clear]
    let screenTitle: String? = L10n.filters
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let games: [SavedGame]
    private var selectedFilters: [GameFilter]?
    
    init(
        games: [SavedGame],
        selectedFilters: [GameFilter]?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.games = games
        self.selectedFilters = selectedFilters
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [MyCollectionFiltersSection(
            games: self.games,
            selectedFilters: self.selectedFilters,
            editDelegate: self
        )]
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .close:
            self.close()
        case .clear:
            self.selectedFilters = []
            self.sections = [MyCollectionFiltersSection(
                games: self.games,
                selectedFilters: self.selectedFilters,
                editDelegate: self
            )]
            Task {
                await self.myCollectionDelegate?.clearFilters()
                self.configureBottomView(shouldEnableButton: true)
                self.containerDelegate?.reloadSection(emptyError: nil)
            }
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
    
    private func getFilters() -> [any Filter] {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any FormCellViewModel)
              }) as? [any FormCellViewModel] else {
            return []
        }

        var selectedFilters = [GameFilter]()
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFormType else { return [] }
            switch formType {
            case .yearOfAcquisition:
                guard let acquisitionYear = formCellVM.value as? String else {
                    break
                }
                selectedFilters.append(GameFilter.acquisitionYear(acquisitionYear))
            case .gameCondition(_):
                guard let conditionText = formCellVM.value as? String else {
                    break
                }
                selectedFilters.append(GameFilter.gameCondition(conditionText))
            case .gameCompleteness(_):
                guard let completenessText = formCellVM.value as? String else {
                    break
                }
                selectedFilters.append(GameFilter.gameCompleteness(completenessText))
            case .gameRegion(_):
                guard let regionText = formCellVM.value as? String else {
                    break
                }
                selectedFilters.append(GameFilter.gameRegion(regionText))
            case .storageArea:
                guard let storageArea = formCellVM.value as? String else {
                    break
                }
                selectedFilters.append(GameFilter.storageArea(storageArea))
            case .rating:
                // TODO
                break
            default:
                break
            }
        }
        self.selectedFilters = selectedFilters
        return selectedFilters
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
            } else if currentValue == nil {
                shouldEnableButton = true
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
        let selectedFilters = self.getFilters()
        guard !selectedFilters.isEmpty else {
            await self.myCollectionDelegate?.clearFilters()
            self.close()
            return
        }
        self.myCollectionDelegate?.apply(filters: selectedFilters)
        self.close()
    }
}
