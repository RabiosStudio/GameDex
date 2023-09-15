//
//  AddGameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

// sourcery: AutoMockable
protocol AddGameDetailsViewModelDelegate: AnyObject {
    func didAddNewGame()
}

final class AddGameDetailsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.fillGameDetails
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var addGameDelegate: AddGameDetailsViewModelDelegate?
    
    private let game: Game
    private let localDatabase: Database
    private let alertDisplayer: AlertDisplayer
    
    init(
        game: Game,
        localDatabase: Database,
        addGameDelegate: AddGameDetailsViewModelDelegate?,
        alertDisplayer: AlertDisplayer
    ) {
        self.progress = 3/3
        self.game = game
        self.localDatabase = localDatabase
        self.sections = [AddGameDetailsSection(game: self.game)]
        self.addGameDelegate = addGameDelegate
        self.alertDisplayer = alertDisplayer
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.configureBottomView()
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        self.addGameDelegate?.didAddNewGame()
        _ =  Routing.shared.route(
            navigationStyle: .dismiss {
            }
        )
    }
    
    private func configureBottomView() {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.addGameToCollection
        )
        self.containerDelegate?.configureBottomView(
            contentViewFactory: buttonContentViewFactory
        )
    }
}

extension AddGameDetailsViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton() {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any CollectionFormCellViewModel)
              }) as? [any CollectionFormCellViewModel] else {
            return
        }
        
        var acquisitionYear, gameCondition, gameCompleteness, gameRegion, storageArea, notes: String?
        var rating: Int?
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? AddGameFormType else { return }
            switch formType {
            case .yearOfAcquisition:
                acquisitionYear = formCellVM.value as? String
            case .gameCondition(_):
                gameCondition = formCellVM.value as? String
            case .gameCompleteness(_):
                gameCompleteness = formCellVM.value as? String
            case .gameRegion(_):
                gameRegion = formCellVM.value as? String
            case .storageArea:
                storageArea = formCellVM.value as? String
            case .rating:
                rating = formCellVM.value as? Int
            case .notes:
                notes = formCellVM.value as? String
            }
        }
        
        let gameToSave = SavedGame(
            game: self.game,
            acquisitionYear: acquisitionYear,
            gameCondition: gameCondition,
            gameCompleteness: gameCompleteness,
            gameRegion: gameRegion,
            storageArea: storageArea,
            rating: rating,
            notes: notes
        )
        
        self.localDatabase.add(newEntity: gameToSave) { [weak self] error in
            if error != nil {
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .error,
                        description: L10n.saveGameErrorDescription
                    )
                )
                self?.configureBottomView()
            } else {
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .success,
                        description: L10n.saveGameSuccessDescription
                    )
                )
                // the right button item is .close so the method will dismiss the view presented
                self?.didTapRightButtonItem()
            }
        }
    }
}
