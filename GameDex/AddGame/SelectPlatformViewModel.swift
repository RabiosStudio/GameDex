//
//  SelectPlatformViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformViewModel: CollectionViewModel {
    var isSearchable: Bool = true
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.stepOneOutOfThree
    var sections = [Section]()
    weak var containerDelegate: ContainerViewControllerDelegate?
    
    private var platforms = [Platform]()
    
    init() {
        self.progress = 1/3
    }
    
    func loadData(callback: @escaping (EmptyError?) -> ()) {
        Task {
            await fetchPlatforms()
            callback(nil)
        }
    }
    
    func fetchPlatforms() async {
        let session = AlamofireAPI()
        let endpoint = GetPlatformsEndpoint()
        
        // get reponse
        let result = await session.getData(with: endpoint, resultType: SearchPlatformsData.self)
        
        switch result {
        case .success(let data):
            let platforms = DataConverter.convert(remotePlatforms: data.platforms)
            self.platforms = platforms
            self.sections = [SelectPlatformSection(platforms: self.platforms)]
        case .failure(let error):
            print(error)
            // TODO: Manage errors
        }
    }
}
