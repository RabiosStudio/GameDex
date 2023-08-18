//
//  AddManuallyFirstStep.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

protocol AddGameStepOneVMDelegate: AnyObject {
    func didTapPrimaryButton()
}

class AddGameStepOneViewModel: CollectionViewModel {
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.stepOne
    var sections: [Section]
    weak var containerDelegate: ContainerViewControllerDelegate?
    lazy var continueContentViewFactory = ContinueContentViewFactory(delegate: self)
    
    init() {
        self.sections = [AddGameStepOneSection()]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.containerDelegate?.configureBottomView(
            contentViewFactory: self.continueContentViewFactory
        )
        callback(nil)
    }
}

extension AddGameStepOneViewModel: AddGameStepOneVMDelegate {
    func didTapPrimaryButton() {
        print("button tapped!")
    }
}
