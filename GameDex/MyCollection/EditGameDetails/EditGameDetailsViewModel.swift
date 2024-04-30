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
    private let cloudDatabase: CloudDatabase
    private var alertDisplayer: AlertDisplayer
    private let savedValues: [Any?]
    private let platform: Platform
    private let authenticationService: AuthenticationService
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var alertDelegate: AlertDisplayerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(
        savedGame: SavedGame,
        platform: Platform,
        localDatabase: LocalDatabase,
        cloudDatabase: CloudDatabase,
        alertDisplayer: AlertDisplayer,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        authenticationService: AuthenticationService
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
        self.cloudDatabase = cloudDatabase
        self.authenticationService = authenticationService
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
}

extension EditGameDetailsViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        guard let gameToSave = getGameToSave() else { return }
        
        guard let userId = self.authenticationService.getUserId() else {
            await self.saveInLocal(gameToSave: gameToSave)
            return
        }
        
        await self.saveInCloud(userId: userId, gameToSave: gameToSave)
    }
}

extension EditGameDetailsViewModel: EditFormDelegate {
    func enableSaveButtonIfNeeded() {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any FormCellViewModel)
              }) as? [any FormCellViewModel] else {
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
        self.configureBottomView(shouldEnableButton: shouldEnableButton)
    }
}

extension EditGameDetailsViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        guard let userId = self.authenticationService.getUserId() else {
            await self.removeInLocal()
            return
        }
        await self.removeInCloud(userId: userId)
    }
}

private extension EditGameDetailsViewModel {
    func presentAlertBeforeDeletingGame() {
        self.alertDisplayer.presentBasicAlert(
            parameters: AlertViewModel(
                alertType: .warning,
                description: L10n.warningRemoveGameDescription
            )
        )
    }
    
    func handleRemoveGameSuccess() async {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .success,
                description: L10n.removeGameSuccessDescription
            )
        )
        await self.myCollectionDelegate?.reloadCollection()
        self.containerDelegate?.goBackToRootViewController()
    }
    func handleRemoveGameError() {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .error,
                description: L10n.removeGameErrorDescription
            )
        )
    }
    
    func configureBottomView(shouldEnableButton: Bool) {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.saveChanges,
            shouldEnable: shouldEnableButton,
            position: .bottom
        )
        self.containerDelegate?.configureSupplementaryView(contentViewFactory: buttonContentViewFactory)
    }
    
    func getGameToSave() -> SavedGame? {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any FormCellViewModel)
              }) as? [any FormCellViewModel] else {
            return nil
        }
        
        var acquisitionYear, storageArea, notes: String?
        var rating: Int?
        var gameCondition: GameCondition?
        var gameCompleteness: GameCompleteness?
        var gameRegion: GameRegion?
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFormType else { return nil }
            switch formType {
            case .yearOfAcquisition:
                acquisitionYear = formCellVM.value as? String
            case .gameCondition(_):
                if let conditionText = formCellVM.value as? String {
                    gameCondition = GameCondition.getRawValue(
                        value: conditionText
                    )
                }
            case .gameCompleteness(_):
                if let completenessText = formCellVM.value as? String {
                    gameCompleteness = GameCompleteness.getRawValue(
                        value: completenessText
                    )
                }
            case .gameRegion(_):
                if let regionText = formCellVM.value as? String {
                    gameRegion = GameRegion.getRawValue(
                        value: regionText
                    )
                }
            case .storageArea:
                storageArea = formCellVM.value as? String
            case .rating:
                rating = formCellVM.value as? Int
            case .notes:
                notes = formCellVM.value as? String
            }
        }
        
        return SavedGame(
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
    }
    
    func saveInLocal(gameToSave: SavedGame) async {
        guard let error = await self.localDatabase.replace(savedGame: gameToSave) else {
            await self.handleEditGameSuccess()
            return
        }
        await self.handleEditGameFailure(error: error)
    }
    
    func saveInCloud(userId: String, gameToSave: SavedGame) async {
        guard let error = await self.cloudDatabase.saveGame(userId: userId, game: gameToSave, platform: self.platform, editingEntry: true) else {
            await self.handleEditGameSuccess()
            return
        }
        await self.handleEditGameFailure(error: error)
    }
    
    func handleEditGameSuccess() async {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .success,
                description: L10n.updateSuccessDescription
            )
        )
        self.configureBottomView(shouldEnableButton: false)
        await self.myCollectionDelegate?.reloadCollection()
    }
    
    func handleEditGameFailure(error: DatabaseError) async {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .error,
                description: L10n.updateErrorDescription
            )
        )
        self.configureBottomView(shouldEnableButton: true)
        return
    }
    
    func removeInLocal() async {
        guard await self.localDatabase.remove(savedGame: self.savedGame) == nil else {
            self.handleRemoveGameError()
            return
        }
        await self.handleRemoveGameSuccess()
    }
    
    func removeInCloud(userId: String) async {
        guard await self.cloudDatabase.removeGame(userId: userId, platform: self.platform, savedGame: self.savedGame) == nil else {
            self.handleRemoveGameError()
            return
        }
        await self.handleRemoveGameSuccess()
    }
}
