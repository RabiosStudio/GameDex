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
    weak var gameDetailsDelegate: GameDetailsViewModelDelegate?
    
    private let game: Game
    private let platform: Platform
    private let localDatabase: Database
    private let alertDisplayer: AlertDisplayer
    
    init(
        game: Game,
        platform: Platform,
        localDatabase: Database,
        gameDetailsDelegate: GameDetailsViewModelDelegate?,
        alertDisplayer: AlertDisplayer
    ) {
        self.progress = 3/3
        self.game = game
        self.platform = platform
        self.localDatabase = localDatabase
        self.sections = [
            AddGameDetailsSection(
                game: self.game,
                platform: self.platform
            )
        ]
        self.gameDetailsDelegate = gameDetailsDelegate
        self.alertDisplayer = alertDisplayer
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.configureBottomView()
        callback(nil)
    }
    
    func didTapRightButtonItem() {
        self.gameDetailsDelegate?.reloadCollection()
        _ = Routing.shared.route(navigationStyle: .dismiss(completionBlock: nil))
    }
    
    private func configureBottomView() {
        let buttonContentViewFactory = PrimaryButtonContentViewFactory(
            delegate: self,
            buttonTitle: L10n.addGameToCollection,
            shouldEnable: true
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
            game: self.game,
            acquisitionYear: acquisitionYear,
            gameCondition: gameCondition,
            gameCompleteness: gameCompleteness,
            gameRegion: gameRegion,
            storageArea: storageArea,
            rating: rating,
            notes: notes
        )
        
        self.localDatabase.add(newEntity: gameToSave, platform: self.platform) { [weak self] error in
            self?.alertDisplayer.presentTopFloatAlert(
                parameters: AlertViewModel(
                    alertType: error == nil ? .success : (error == .itemAlreadySaved ? .warning : .error),
                    description: error == nil ? L10n.saveGameSuccessDescription : (error == .itemAlreadySaved ? L10n.warningGameAlreadyInDatabase : L10n.saveGameErrorDescription)
                )
            )
            
            guard error != nil else {
                self?.configureBottomView()
                return
            }
            // the right button item is .close so the method will dismiss the view presented
            self?.didTapRightButtonItem()
        }
    }
}
