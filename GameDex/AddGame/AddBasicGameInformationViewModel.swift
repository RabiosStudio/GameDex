//
//  AddManuallyFirstStep.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class AddBasicGameInformationViewModel: CollectionViewModel {
    var isBounceable: Bool = false
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.stepOneOutOfThree
    var sections: [Section]
    weak var containerDelegate: ContainerViewControllerDelegate?
    lazy var continueContentViewFactory = ContinueContentViewFactory(delegate: self)
    
    var platform: SearchPlatformsData?
    
    init() {
        self.sections = [AddBasicGameInformationSection()]
        self.progress = 1/3
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        self.containerDelegate?.configureBottomView(contentViewFactory: self.continueContentViewFactory)
        callback(nil)
    }
}

extension AddBasicGameInformationViewModel: PrimaryButtonDelegate {
    
    func didTapPrimaryButton() async {
        let session = AlamofireAPI()
        let endpoint = GetPlatformsEndpoint()
        
        // get reponse
        let result = await session.getData(with: endpoint, resultType: SearchPlatformsData.self)
        
        switch result {
        case .success(let platforms):
            print(platforms)
        case .failure(let error):
            print(error)
        }
    }
}
