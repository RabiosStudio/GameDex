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
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.fillGameDetails
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    private let navigationStyle: NavigationStyle = .dismiss(completionBlock: nil)
    
    private let game: Game
    private let localDatabase: LocalDatabase
    
    init(game: Game, localDatabase: LocalDatabase) {
        self.progress = 3/3
        self.game = game
        self.localDatabase = localDatabase
        self.sections = [AddGameDetailsSection(game: self.game)]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.configureBottomView()
        callback(nil)
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
                   
        var acquisitionYear: String?
        var gameCondition: String?
        var gameCompleteness: String?
        var gameRegion: String?
        var storageArea: String?
        var rating: Int?
        var notes: String?
        
        for formCellVM in formCellsVM {
            switch formCellVM.formType {
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
        
        let saveResult = self.localDatabase.add(
            newEntity: gameToSave
        )
        switch saveResult {
        case .success(let successText):
            AlertService.shared.presentAlert(
                title: successText,
                description: L10n.gameSavedSuccessTitle,
                type: .success
            )
            _ =  Routing.shared.route(navigationStyle: self.navigationStyle)
        case .failure(_):
            AlertService.shared.presentAlert(
                title: L10n.errorTitle,
                description: L10n.saveGameErrorTitle,
                type: .error
            )
            self.configureBottomView()
        }
    }
}
