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
    var isRefreshable: Bool = false
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]? = [.close, .clear]
    let screenTitle: String? = L10n.filters
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let games: [SavedGame]
    var gameFilterForm: GameFilterForm
    
    init(
        games: [SavedGame],
        gameFilterForm: GameFilterForm?,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.games = games
        self.gameFilterForm = gameFilterForm ?? GameFilterForm()
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.updateSections()
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) async {
        switch buttonItem {
        case .close:
            self.close()
        case .clear:
            self.gameFilterForm = GameFilterForm()
            self.sections = [MyCollectionFiltersSection(
                games: self.games,
                gameFilterForm: self.gameFilterForm,
                formDelegate: self
            )]
            self.containerDelegate?.reloadSections(emptyError: nil)
            self.configureBottomView(shouldEnableButton: true)
            await self.myCollectionDelegate?.clearFilters()
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
        var selectedFilters = [GameFilter]()
        
        if let isPhysical = self.gameFilterForm.isPhysical {
            selectedFilters.append(
                GameFilter.isPhysical(isPhysical)
            )
        }
        if let acquisitionYear = self.gameFilterForm.acquisitionYear {
            selectedFilters.append(GameFilter.acquisitionYear(acquisitionYear))
        }
        if let gameCondition = self.gameFilterForm.gameCondition {
            let conditionValue = GameCondition.getRawValue(
                value: gameCondition.value
            )
            selectedFilters.append(
                GameFilter.gameCondition(conditionValue.rawValue)
            )
        }
        if let gameCompleteness = self.gameFilterForm.gameCompleteness {
            let completenessValue = GameCompleteness.getRawValue(
                value: gameCompleteness.value
            )
            selectedFilters.append(
                GameFilter.gameCompleteness(completenessValue.rawValue)
            )
        }
        if let gameRegion = self.gameFilterForm.gameRegion {
            let regionValue = GameRegion.getRawValue(
                value: gameRegion.value
            )
            selectedFilters.append(
                GameFilter.gameRegion(regionValue.rawValue)
            )
        }
        if let storageArea = self.gameFilterForm.storageArea {
            selectedFilters.append(GameFilter.storageArea(storageArea))
        }
        if let rating = self.gameFilterForm.rating {
            if rating != .zero {
                selectedFilters.append(GameFilter.rating(rating))
            }
        }
        return selectedFilters
    }
}

extension MyCollectionFiltersViewModel: FormDelegate {
    func didUpdate(value: Any, for type: any FormType) {
        guard let formType = type as? GameFilterFormType else {
            return
        }
        switch formType {
        case .acquisitionYear:
            self.gameFilterForm.acquisitionYear = value as? String
        case .gameCondition:
            if let stringValue = value as? String {
                self.gameFilterForm.gameCondition = GameCondition.getRawValue(
                    value: stringValue
                )
            }
        case .gameCompleteness:
            if let stringValue = value as? String {
                self.gameFilterForm.gameCompleteness = GameCompleteness.getRawValue(
                    value: stringValue
                )
            }
        case .gameRegion:
            if let stringValue = value as? String {
                self.gameFilterForm.gameRegion = GameRegion.getRawValue(
                    value: stringValue
                )
            }
        case .storageArea:
            self.gameFilterForm.storageArea = value as? String
        case .rating:
            self.gameFilterForm.rating = value as? Int ?? .zero
        case .isPhysical:
            let stringValue = value as? String
            switch stringValue {
            case GameFormat.physical.text:
                self.gameFilterForm.isPhysical = true
            case GameFormat.digital.text:
                self.gameFilterForm.isPhysical = false
            case L10n.any:
                self.gameFilterForm.isPhysical = nil
            default:
                break
            }
        }
        self.configureBottomView(shouldEnableButton: true)
    }
    
    func refreshSections() {
        self.updateSections()
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
    
    func updateSections() {
        self.sections = [MyCollectionFiltersSection(
            games: self.games,
            gameFilterForm: self.gameFilterForm,
            formDelegate: self
        )]
    }
}

// MARK: - PrimaryButtonDelegate
extension MyCollectionFiltersViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        let selectedFilters = self.getFilters()
        guard !selectedFilters.isEmpty else {
            await self.myCollectionDelegate?.clearFilters()
            self.configureBottomView(shouldEnableButton: false)
            self.close()
            return
        }
        await self.myCollectionDelegate?.apply(filters: selectedFilters)
        self.close()
    }
}
