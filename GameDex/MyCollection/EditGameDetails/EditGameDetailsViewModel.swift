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
extension EditGameDetailsViewModel: EditFormDelegate {
    func enableSaveButton() {
        configureBottomView(shouldEnableButton: true)
    }
}
extension EditGameDetailsViewModel: AlertDisplayerDelegate {
    func didTapOkButton() {
        }
}
