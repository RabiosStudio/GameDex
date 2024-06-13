//
//  GameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 03/06/2024.
//

import Foundation
import UIKit

final class GameDetailsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var isRefreshable: Bool = false
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]?
    let screenTitle: String?
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    var gameForm: GameForm
    private let gameDetailsContext: GameDetailsContext
    private let game: Game
    private var savedGame: SavedGame?
    private var initialGameForm: GameForm
    private let platform: Platform
    private let localDatabase: LocalDatabase
    private let cloudDatabase: CloudDatabase
    private var alertDisplayer: AlertDisplayer
    private let authenticationService: AuthenticationService
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var alertDelegate: AlertDisplayerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    init(
        gameDetailsContext: GameDetailsContext,
        platform: Platform,
        localDatabase: LocalDatabase,
        cloudDatabase: CloudDatabase,
        alertDisplayer: AlertDisplayer,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        authenticationService: AuthenticationService
    ) {
        self.platform = platform
        self.gameDetailsContext = gameDetailsContext
        switch gameDetailsContext {
        case let .add(game):
            self.game = game
            self.gameForm = GameForm(isPhysical: true, rating: 0)
            self.progress = DesignSystem.fullProgress
            self.buttonItems = [.close]
            self.screenTitle = L10n.fillGameDetails
        case let .edit(savedGame):
            self.savedGame = savedGame
            self.game = savedGame.game
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
            self.buttonItems = [.delete]
            self.screenTitle = L10n.myCollection
        }
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
        switch self.gameDetailsContext {
        case .add:
            self.configureBottomView(shouldEnableButton: true)
        case .edit:
            self.configureBottomView(shouldEnableButton: false)
        }
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .delete:
            self.presentAlertBeforeDeletingGame()
        case .close:
            self.close()
        default:
            break
        }
    }
}

extension GameDetailsViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        guard let gameToSave = self.getGameToSave() else { return }
        guard let userId = self.authenticationService.getUserId() else {
            await self.saveInLocal(gameToSave: gameToSave)
            return
        }
        await self.saveInCloud(userId: userId, gameToSave: gameToSave)
    }
}

extension GameDetailsViewModel: FormDelegate {
    func didUpdate(value: Any, for type: any FormType) {
        guard let formType = type as? GameFormType else {
            return
        }
        switch formType {
        case .acquisitionYear:
            self.gameForm.acquisitionYear = value as? String
        case .gameCondition:
            if let stringValue = value as? String {
                self.gameForm.gameCondition = GameCondition.getRawValue(
                    value: stringValue
                )
            }
        case .gameCompleteness:
            if let stringValue = value as? String {
                self.gameForm.gameCompleteness = GameCompleteness.getRawValue(
                    value: stringValue
                )
            }
        case .gameRegion:
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
        
        switch self.gameDetailsContext {
        case .edit:
            self.configureBottomView(
                shouldEnableButton: self.initialGameForm != self.gameForm
            )
        default:
            break
        }
    }
    
    func refreshSectionsDependingOnGameFormat() {
        self.updateSections(with: self.gameForm)
        self.containerDelegate?.reloadSections(emptyError: nil)
        
    }
}

extension GameDetailsViewModel: AlertDisplayerDelegate {
    func didTapOkButton() async {
        guard let userId = self.authenticationService.getUserId() else {
            await self.removeInLocal()
            return
        }
        await self.removeInCloud(userId: userId)
    }
}

private extension GameDetailsViewModel {
    func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
    
    func updateSections(with gameForm: GameForm) {
        self.sections = [GameDetailsSection(
            game: self.game,
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
    
    func configureBottomView(shouldEnableButton: Bool) {
        let buttonTitle: String
        switch self.gameDetailsContext {
        case .add:
            buttonTitle = L10n.addGameToCollection
        case .edit:
            buttonTitle = L10n.saveChanges
        }
        
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: buttonTitle,
            shouldEnable: shouldEnableButton,
            position: .bottom
        )
        self.containerDelegate?.configureSupplementaryView(contentViewFactory: buttonContentViewFactory)
    }

    func getGameToSave() -> SavedGame? {
        return SavedGame(
            game: self.game,
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
        switch self.gameDetailsContext {
        case .add:
            guard let error = await self.localDatabase.add(newEntity: gameToSave, platform: self.platform) else {
                await self.handleSuccess()
                return
            }
            await self.handleFailure(error: error)
        case .edit:
            guard let error = await self.localDatabase.replace(savedGame: gameToSave) else {
                await self.handleSuccess()
                return
            }
            await self.handleFailure(error: error)
        }
    }
    
    func saveInCloud(userId: String, gameToSave: SavedGame) async {
        switch self.gameDetailsContext {
        case .add:
            guard let error = await self.cloudDatabase.saveGame(userId: userId, game: gameToSave, platform: self.platform) else {
                await self.handleSuccess()
                return
            }
            await self.handleFailure(error: error)
        case let .edit(savedGame):
            guard let error = await self.cloudDatabase.replaceGame(userId: userId, newGame: gameToSave, oldGame: savedGame, platform: self.platform) else {
                await self.handleSuccess()
                return
            }
            await self.handleFailure(error: error)
        }
    }
    
    func handleSuccess() async {
        switch self.gameDetailsContext {
        case .add:
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: .success,
                    description: L10n.saveGameSuccessDescription
                )
            )
            await self.myCollectionDelegate?.reloadCollection()
            self.close()
        case .edit:
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
    }
    
    func handleFailure(error: DatabaseError) async {
        let errorDescription: String
        switch self.gameDetailsContext {
        case .add:
            errorDescription = L10n.saveGameErrorDescription
        case .edit:
            errorDescription = L10n.updateErrorDescription
        }
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: error == .itemAlreadySaved ? .warning : .error,
                description: error == .itemAlreadySaved ? L10n.warningGameAlreadyInDatabase : errorDescription
            )
        )
        self.configureBottomView(shouldEnableButton: true)
    }
    
    func removeInLocal() async {
        guard let savedGame,
              await self.localDatabase.remove(savedGame: savedGame) == nil else {
            self.handleRemoveGameError()
            return
        }
        await self.handleRemoveGameSuccess()
    }
    
    func removeInCloud(userId: String) async {
        guard let savedGame,
              await self.cloudDatabase.removeGame(userId: userId, platform: self.platform, savedGame: savedGame) == nil else {
            self.handleRemoveGameError()
            return
        }
        await self.handleRemoveGameSuccess()
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
}
