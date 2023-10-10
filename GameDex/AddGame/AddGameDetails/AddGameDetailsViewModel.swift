//
//  AddGameDetailsViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class AddGameDetailsViewModel: CollectionViewModel {
    var searchViewModel: SearchViewModel?
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItems: [AnyBarButtonItem]? = [.close]
    let screenTitle: String? = L10n.fillGameDetails
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    weak var myCollectionDelegate: MyCollectionViewModelDelegate?
    
    private let game: Game
    private let platform: Platform
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
        self.progress = 3/3
        self.game = game
        self.platform = platform
        self.sections = [
            AddGameDetailsSection(
                game: self.game,
                platform: self.platform
            )
        ]
        self.localDatabase = localDatabase
        self.cloudDatabase = cloudDatabase
        self.myCollectionDelegate = myCollectionDelegate
        self.alertDisplayer = alertDisplayer
        self.authenticationService = authenticationService
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.configureBottomView()
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        self.close()
    }
    
    private func close() {
        Routing.shared.route(
            navigationStyle: .dismiss(
                completionBlock: nil
            )
        )
    }
    
    private func configureBottomView() {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.addGameToCollection,
            shouldEnable: true,
            position: .bottom
        )
        self.containerDelegate?.configureSupplementaryView(contentViewFactory: buttonContentViewFactory)
    }
}

extension AddGameDetailsViewModel: PrimaryButtonDelegate {
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
        
        if rating == nil {
            rating = .zero
        }
        
        let gameToSave = SavedGame(
            game: self.game,
            acquisitionYear: acquisitionYear,
            gameCondition: gameCondition,
            gameCompleteness: gameCompleteness,
            gameRegion: gameRegion,
            storageArea: storageArea,
            rating: rating,
            notes: notes,
            lastUpdated: Date()
        )
        
        guard let userId = self.authenticationService.getUserId() else {
            guard let error = await self.localDatabase.add(newEntity: gameToSave, platform: self.platform) else {
                self.alertDisplayer.presentTopFloatAlert(
                    parameters: AlertViewModel(
                        alertType: .success,
                        description: L10n.saveGameSuccessDescription
                    )
                )
                await self.myCollectionDelegate?.reloadCollection()
                self.close()
                return
            }
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: error == .itemAlreadySaved ? .warning : .error,
                    description: error == .itemAlreadySaved ? L10n.warningGameAlreadyInDatabase : L10n.saveGameErrorDescription
                )
            )
            self.configureBottomView()
            return
        }
        let platform = Platform(
            title: self.platform.title,
            id: self.platform.id,
            games: [gameToSave]
        )
        
        guard await self.cloudDatabase.saveGame(userId: userId, platform: platform) == nil else {
            self.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: .error,
                    description: L10n.saveGameErrorDescription
                )
            )
            self.configureBottomView()
            return
        }
        self.alertDisplayer.presentTopFloatAlert(
            parameters: AlertViewModel(
                alertType: .success,
                description: L10n.saveGameSuccessDescription
            )
        )
        self.configureBottomView()
        await self.myCollectionDelegate?.reloadCollection()
        self.close()
    }
}
