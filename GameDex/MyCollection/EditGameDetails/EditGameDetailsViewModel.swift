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
    private var initialGameForm: GameForm
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
            rating: savedGame.rating ?? .zero,
            notes: savedGame.notes
        )
        self.initialGameForm = self.gameForm
        self.localDatabase = localDatabase
        self.cloudDatabase = cloudDatabase
        self.authenticationService = authenticationService
        self.alertDisplayer = alertDisplayer
        self.alertDisplayer.alertDelegate = self
        self.myCollectionDelegate = myCollectionDelegate
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.updateSections(with: self.initialGameForm)
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
        guard let gameToSave = self.getGameToSave() else { return }
        
        guard let userId = self.authenticationService.getUserId() else {
            await self.saveInLocal(gameToSave: gameToSave)
            return
        }
        
        await self.saveInCloud(userId: userId, gameToSave: gameToSave)
    }
}

extension EditGameDetailsViewModel: FormDelegate {
    func didUpdate(value: Any, for type: any FormType) {
        guard let formType = type as? GameFormType else {
            return
        }
        switch formType {
        case .yearOfAcquisition:
            self.gameForm.acquisitionYear = value as? String
        case .gameCondition(_):
            if let stringValue = value as? String {
                self.gameForm.gameCondition = GameCondition.getRawValue(
                    value: stringValue
                )
            }
        case .gameCompleteness(_):
            if let stringValue = value as? String {
                self.gameForm.gameCompleteness = GameCompleteness.getRawValue(
                    value: stringValue
                )
            }
        case .gameRegion(_):
            if let stringValue = value as? String {
                self.gameForm.gameRegion = GameRegion.getRawValue(
                    value: stringValue
                )
            }
        case .storageArea:
            self.gameForm.storageArea = value as? String
        case .rating:
            self.gameForm.rating = value as? Int ?? .zero
        case .notes:
            self.gameForm.notes = value as? String
        case .isPhysical:
            let stringValue = value as? String
            switch stringValue {
            case GameFormat.physical.text:
                self.gameForm.isPhysical = true
            case GameFormat.digital.text:
                self.gameForm.isPhysical = false
            default:
                break
            }
        }
    }
    
    func refreshSectionsDependingOnGameFormat() {
        self.updateSections(with: self.gameForm)
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
    
    func enableSaveButtonIfNeeded() {
        self.configureBottomView(
            shouldEnableButton: self.initialGameForm != self.gameForm
        )
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
    func updateSections(with gameForm: GameForm) {
        self.sections = [EditGameDetailsSection(
            savedGame: self.savedGame,
            platformName: self.platform.title,
            gameForm: self.gameForm,
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
