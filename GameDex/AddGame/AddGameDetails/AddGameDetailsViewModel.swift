//
//  AddGameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

final class AddGameDetailsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var buttonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.fillGameDetails
    var sections = [Section]()
    var layoutMargins: UIEdgeInsets?
    
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let game: Game
    private let platform: Platform
    private var gameForm: GameForm
    private let localDatabase: LocalDatabase
    private let cloudDatabase: CloudDatabase
    private let alertDisplayer: AlertDisplayer
    private let authenticationService: AuthenticationService
    
    init(
        game: Game,
        platform: Platform,
        localDatabase: LocalDatabase,
        cloudDatabase: CloudDatabase,
        myCollectionDelegate: MyCollectionViewModelDelegate?,
        alertDisplayer: AlertDisplayer,
        authenticationService: AuthenticationService
    ) {
        self.progress = DesignSystem.fullProgress
        self.game = game
        self.platform = platform
        self.localDatabase = localDatabase
        self.cloudDatabase = cloudDatabase
        self.myCollectionDelegate = myCollectionDelegate
        self.alertDisplayer = alertDisplayer
        self.authenticationService = authenticationService
        self.gameForm = GameForm(
            isPhysical: true,
            acquisitionYear: nil,
            gameCondition: nil,
            gameCompleteness: nil,
            gameRegion: nil,
            storageArea: nil,
            rating: .zero,
            notes: nil
            )
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.updateSections(gameForm: self.gameForm)
        self.configureBottomView()
        callback(nil)
    }
    
    func didTap(buttonItem: AnyBarButtonItem) {
        switch buttonItem {
        case .close:
            self.close()
        default:
            break
        }
    }
}

// MARK: - PrimaryButtonDelegate

extension AddGameDetailsViewModel: PrimaryButtonDelegate {
    func didTapPrimaryButton(with title: String?) async {
        guard let gameToSave = self.getGameToSave() else { return }
        
        guard let userId = self.authenticationService.getUserId() else {
            await self.saveInLocal(gameToSave: gameToSave)
            return
        }
        
        await self.saveInCloud(userId: userId, gameToSave: gameToSave)
    }
}

// MARK: - FormDelegate
extension AddGameDetailsViewModel: FormDelegate {
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
        self.updateSections(gameForm: self.gameForm)
        self.containerDelegate?.reloadSections(emptyError: nil)
    }
}

private extension AddGameDetailsViewModel {
    func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
    
    func configureBottomView() {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.addGameToCollection,
            shouldEnable: true,
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
    
    func updateSections(gameForm: GameForm ) {
        self.sections = [AddGameDetailsSection(
            game: self.game,
            platform: self.platform,
            gameForm: gameForm,
            formDelegate: self
        )]
    }
    
    func saveInLocal(gameToSave: SavedGame) async {
        guard let error = await self.localDatabase.add(newEntity: gameToSave, platform: self.platform) else {
            await self.handleSuccess()
            return
        }
        await self.handleFailure(error: error)
    }
    
    func saveInCloud(userId: String, gameToSave: SavedGame) async {
        guard let error = await self.cloudDatabase.saveGame(
            userId: userId,
            game: gameToSave,
            platform: self.platform
        ) else {
            await self.handleSuccess()
            return
        }
        await self.handleFailure(error: error)
    }
    
    func handleSuccess() async {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .success,
                description: L10n.saveGameSuccessDescription
            )
        )
        await self.myCollectionDelegate?.reloadCollection()
        self.close()
    }
    
    func handleFailure(error: DatabaseError) async {
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: error == .itemAlreadySaved ? .warning : .error,
                description: error == .itemAlreadySaved ? L10n.warningGameAlreadyInDatabase : L10n.saveGameErrorDescription
            )
        )
        self.configureBottomView()
    }
}
