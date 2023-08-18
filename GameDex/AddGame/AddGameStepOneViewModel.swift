//
//  AddManuallyFirstStep.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

class AddGameStepOneViewModel: CollectionViewModel {
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.stepOne
    var sections: [Section]
    
    init() {
        self.sections = [AddGameStepOneSection()]
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        callback(nil)
    }
}
