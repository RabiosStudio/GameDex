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
    var buttonItems: [AnyBarButtonItem]? = [.close, .clear]
    let screenTitle: String? = L10n.filters
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let games: [SavedGame]
    var selectedFilters: [GameFilter]?
    
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
            formDelegate: self
        )]
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) async {
        switch buttonItem {
        case .close:
            self.close()
        case .clear:
            self.selectedFilters = []
            self.sections = [MyCollectionFiltersSection(
                games: self.games,
                selectedFilters: self.selectedFilters,
                formDelegate: self
            )]
            self.configureBottomView(shouldEnableButton: true)
            self.containerDelegate?.reloadSections(emptyError: nil)
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
    
    private func getFilters() -> [GameFilter] {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any FormCellViewModel)
              }) as? [any FormCellViewModel] else {
            return []
        }

        var selectedFilters = [GameFilter]()
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFilterFormType else { return [] }
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
                let condition = GameCondition.getRawValue(
                    value: conditionText
                )
                selectedFilters.append(GameFilter.gameCondition(condition.rawValue))
            case .gameCompleteness(_):
                guard let completenessText = formCellVM.value as? String else {
                    break
                }
                let completeness = GameCompleteness.getRawValue(
                    value: completenessText
                )
                selectedFilters.append(GameFilter.gameCompleteness(completeness.rawValue))
            case .gameRegion(_):
                guard let regionText = formCellVM.value as? String else {
                    break
                }
                let region = GameRegion.getRawValue(
                    value: regionText
                )
                selectedFilters.append(GameFilter.gameRegion(region.rawValue))
            case .storageArea:
                guard let storageArea = formCellVM.value as? String else {
                    break
                }
                selectedFilters.append(GameFilter.storageArea(storageArea))
            case .rating:
                guard let rating = formCellVM.value as? Int,
                      rating != .zero else {
                    break
                }
                selectedFilters.append(GameFilter.rating(rating))
            }
        }
        return selectedFilters
    }
}

extension MyCollectionFiltersViewModel: FormDelegate {
    func didUpdate(value: Any, for type: any FormType) {}
    
    func enableSaveButtonIfNeeded() {
        self.configureBottomView(shouldEnableButton: true)
    }
    
    func refreshSectionsDependingOnGameFormat() {}
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
        await self.myCollectionDelegate?.apply(filters: selectedFilters)
        self.close()
    }
}
