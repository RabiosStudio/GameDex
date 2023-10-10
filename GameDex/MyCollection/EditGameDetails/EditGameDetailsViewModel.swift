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
    var rightButtonItems: [AnyBarButtonItem]? = [.delete]
    let screenTitle: String? = L10n.myCollection
    var sections = [Section]()
    
    private let savedGame: SavedGame
    private let localDatabase: LocalDatabase
    private var alertDisplayer: AlertDisplayer
    private let savedValues: [Any?]
    private let platform: Platform
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var alertDelegate: AlertDisplayerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(
        savedGame: SavedGame,
        platform: Platform,
        localDatabase: LocalDatabase,
        alertDisplayer: AlertDisplayer,
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        self.savedGame = savedGame
        self.savedValues = [
            self.savedGame.acquisitionYear,
            self.savedGame.gameCondition,
            self.savedGame.gameCompleteness,
            self.savedGame.gameRegion,
            self.savedGame.storageArea,
            self.savedGame.rating,
            self.savedGame.notes
        ]
        self.platform = platform
        self.localDatabase = localDatabase
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.sections = [EditGameDetailsSection(
            savedGame: self.savedGame,
            platformName: self.platform.title,
            editDelegate: self
        )]
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        self.presentAlertBeforeDeletingGame()
    }
    
    private func presentAlertBeforeDeletingGame() {
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
            shouldEnable: shouldEnableButton,
            position: .bottom
        )
        self.containerDelegate?.configureSupplementaryView(contentViewFactory: buttonContentViewFactory)
    }
}

extension EditGameDetailsViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton() async {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any CollectionFormCellViewModel)
              }) as? [any CollectionFormCellViewModel] else {
            return
        }
        
        var acquisitionYear, gameCondition, gameCompleteness, gameRegion, storageArea, notes: String?
        var rating: Int?
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFormType else { return }
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
            notes: notes,
            lastUpdated: Date()
        )
        
        guard await self.localDatabase.replace(savedGame: gameToSave) == nil else {
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: .error,
                    description: L10n.updateGameErrorDescription
                )
            )
            self.configureBottomView(shouldEnableButton: true)
            return
        }
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .success,
                description: L10n.updateGameSuccessDescription
            )
        )
        self.configureBottomView(shouldEnableButton: true)
    }
}

extension EditGameDetailsViewModel: EditFormDelegate {
    func enableSaveButtonIfNeeded() {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any CollectionFormCellViewModel)
              }) as? [any CollectionFormCellViewModel] else {
            return
        }
        
        let currentValues: [Any?] = formCellsVM.map { $0.value }
        guard currentValues.count == savedValues.count else {
            return
        }
        
        var shouldEnableButton = false
        for index in 0..<savedValues.count {
            let savedValue = savedValues[index]
            let currentValue = currentValues[index]
            
            if currentValue == nil && savedValue != nil || currentValue != nil && savedValue == nil {
                shouldEnableButton = true
            } else if let savedStringValue = savedValue as? String,
               let currentStringValue = currentValue as? String {
                shouldEnableButton = savedStringValue != currentStringValue
            } else if let saveIntValue = savedValue as? Int,
               let currentIntValue = currentValue as? Int {
                shouldEnableButton = saveIntValue != currentIntValue
            }
            if shouldEnableButton {
                break
            }
        }
        configureBottomView(shouldEnableButton: shouldEnableButton)
    }
}

extension EditGameDetailsViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        guard await self.localDatabase.remove(savedGame: self.savedGame) == nil else {
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: .error,
                    description: L10n.removeGameErrorDescription
                )
            )
            self.configureBottomView(shouldEnableButton: true)
            return
        }
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .success,
                description: L10n.removeGameSuccessDescription
            )
        )
        await self.myCollectionDelegate?.reloadCollection()
        self.containerDelegate?.goBackToRootViewController()
    }
}
