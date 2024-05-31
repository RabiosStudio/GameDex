//
//  EditGameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation
import UIKit

final class EditGameDetailsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]? = [.delete]
    let screenTitle: String? = L10n.myCollection
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    private let savedGame: SavedGame
    private var gameForm: GameForm
    private let localDatabase: LocalDatabase
    private let cloudDatabase: CloudDatabase
    private var alertDisplayer: AlertDisplayer
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
        self.platform = platform
        self.gameForm = GameForm(
            isPhysical: savedGame.isPhysical,
            acquisitionYear: savedGame.acquisitionYear,
            gameCondition: savedGame.gameCondition,
            gameCompleteness: savedGame.gameCompleteness,
            gameRegion: savedGame.gameRegion,
            storageArea: savedGame.storageArea,
            rating: savedGame.rating,
            notes: savedGame.notes
        )
        self.localDatabase = localDatabase
        self.cloudDatabase = cloudDatabase
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.updateSections(with: self.savedGame)
        self.configureBottomView(shouldEnableButton: false)
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .delete:
            self.presentAlertBeforeDeletingGame()
        default:
            break
        }
    }
}

extension EditGameDetailsViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        self.updateGameForm()
        guard let gameToSave = self.getGameToSave() else { return }
        
        guard let userId = self.authenticationService.getUserId() else {
            await self.saveInLocal(gameToSave: gameToSave)
            return
        }
        
        await self.saveInCloud(userId: userId, gameToSave: gameToSave)
    }
}

extension EditGameDetailsViewModel: FormDelegate {
    func refreshSectionsDependingOnGameFormat() {
        guard let editedGame = self.getGameToSave() else {
            return
        }
        self.updateSections(with: editedGame)
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
    
    func enableSaveButtonIfNeeded() {
        self.updateGameForm()
        
        var shouldEnableButton = false
        if self.gameForm.isPhysical != self.savedGame.isPhysical {
            shouldEnableButton = true
        } else if self.gameForm.isPhysical == self.savedGame.isPhysical && self.gameForm.acquisitionYear != self.savedGame.acquisitionYear || self.gameForm.gameCompleteness != self.savedGame.gameCompleteness || self.gameForm.gameCondition != self.savedGame.gameCondition || self.gameForm.gameRegion != self.savedGame.gameRegion || self.gameForm.notes != self.savedGame.notes || self.gameForm.rating != self.savedGame.rating || self.gameForm.storageArea != self.savedGame.storageArea {
            shouldEnableButton = true
        } else {
            shouldEnableButton = false
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
    func updateSections(with savedGame: SavedGame) {
        self.sections = [EditGameDetailsSection(
            savedGame: savedGame,
            platformName: self.platform.title,
            formDelegate: self
        )]
    }
    
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
        self.containerDelegate?.goBackToPreviousScreen()
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
    
    func updateGameForm() {
        guard let firstSection = self.sections.first,
              let formCellsVM = firstSection.cellsVM.filter({ cellVM in
                  return cellVM is (any FormCellViewModel)
              }) as? [any FormCellViewModel] else {
            return
        }
        
        var acquisitionYear, storageArea, notes: String?
        var rating: Int?
        var gameCondition: GameCondition?
        var gameCompleteness: GameCompleteness?
        var gameRegion: GameRegion?
        var isPhysical: Bool = true
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFormType else { return }
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
            case .isPhysical:
                let isPhysicalText = formCellVM.value as? String
                switch isPhysicalText {
                case GameFormat.physical.text:
                    isPhysical = true
                case GameFormat.digital.text:
                    isPhysical = false
                default:
                    break
                }
            }
        }
        
        self.gameForm = GameForm(
            isPhysical: isPhysical,
            acquisitionYear: acquisitionYear,
            gameCondition: gameCondition,
            gameCompleteness: gameCompleteness,
            gameRegion: gameRegion,
            storageArea: storageArea,
            rating: rating,
            notes: notes
        )
    }
    
    func getGameToSave() -> SavedGame? {
        return SavedGame(
            game: self.savedGame.game,
            acquisitionYear: self.gameForm.acquisitionYear,
            gameCondition: self.gameForm.isPhysical ? self.gameForm.gameCondition : nil,
            gameCompleteness: self.gameForm.isPhysical ? self.gameForm.gameCompleteness : nil,
            gameRegion: self.gameForm.isPhysical ? self.gameForm.gameRegion : nil,
            storageArea: self.gameForm.isPhysical ? self.gameForm.storageArea : nil,
            rating: self.gameForm.rating,
            notes: self.gameForm.notes,
            lastUpdated: Date(),
            isPhysical: self.gameForm.isPhysical
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
        guard let error = await self.cloudDatabase.replaceGame(userId: userId, newGame: gameToSave, oldGame: self.savedGame, platform: self.platform) else {
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
        self.containerDelegate?.goBackToPreviousScreen()
    }
    
    func handleEditGameFailure(error: DatabaseError) async {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: error == .itemAlreadySaved ? .warning : .error,
                description: error == .itemAlreadySaved ? L10n.warningGameFormatAlreadyExists : L10n.updateErrorDescription
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
