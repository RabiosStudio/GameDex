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

final class AddGameStepOneViewModel: CollectionViewModel {
    var isScrollable: Bool = false
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.stepOneOutOfThree
    var sections: [Section]
    weak var containerDelegate: ContainerViewControllerDelegate?
    lazy var continueContentViewFactory = ContinueContentViewFactory(delegate: self)
    
    init() {
        self.sections = [AddGameStepOneSection()]
        self.progress = 1/3
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.containerDelegate?.configureBottomView(contentViewFactory: self.continueContentViewFactory)
        callback(nil)
    }
}

extension AddGameStepOneViewModel: AddGameStepOneVMDelegate {
    func didTapPrimaryButton() {
        print("button tapped!")
    }
}
