//
//  EditGameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation

final class EditGameDetailsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .delete
    let screenTitle: String? = L10n.myCollection
    var sections = [Section]()
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private let savedGame: SavedGame
    private let localDatabase: Database
    private lazy var alertDisplayer = AlertDisplayerImpl(alertDelegate: self)
    
    init(
        savedGame: SavedGame,
        localDatabase: Database
    ) {
        self.savedGame = savedGame
        self.localDatabase = localDatabase
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [EditGameDetailsSection(
            savedGame: self.savedGame,
            editDelegate: self
        )]
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        self.alertDisplayer.presentBasicAlert(
            parameters: AlertViewModel(
                alertType: .warning,
                description: L10n.warningRemoveGameDescription,
                cancelButtonTitle: L10n.cancel,
                okButtonTitle: L10n.confirm
            )
        )
    }
    
    private func configureBottomView(shouldEnableButton: Bool) {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.saveChanges,
            shouldEnable: shouldEnableButton
        )
        self.containerDelegate?.configureBottomView(
            contentViewFactory: buttonContentViewFactory
        )
    }
}

extension EditGameDetailsViewModel: PrimaryButtonDelegate {
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
            game: self.savedGame.game,
            acquisitionYear: acquisitionYear,
            gameCondition: gameCondition,
            gameCompleteness: gameCompleteness,
            gameRegion: gameRegion,
            storageArea: storageArea,
            rating: rating,
            notes: notes
        )
        
        self.localDatabase.replace(savedGame: gameToSave) { [weak self] error in
            if error != nil {
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .error,
                        description: L10n.updateGameErrorDescription
                    )
                )
                self?.configureBottomView(shouldEnableButton: true)
            } else {
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .success,
                        description: L10n.updateGameSuccessDescription
                    )
                )
            }
        }
    }
}

extension EditGameDetailsViewModel: EditFormDelegate {
    func enableSaveButton() {
        configureBottomView(shouldEnableButton: true)
    }
}

extension EditGameDetailsViewModel: AlertDisplayerDelegate {
    func didTapOkButton() {
        self.localDatabase.remove(savedGame: self.savedGame) { [weak self] error in
            if error != nil {
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .error,
                        description: L10n.removeGameErrorDescription
                    )
                )
                self?.configureBottomView(shouldEnableButton: true)
            } else {
                self?.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .success,
                        description: L10n.removeGameSuccessDescription
                    )
                )
            }
        }
    }
}
