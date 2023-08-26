//
//  SelectPlatformViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformViewModel: CollectionViewModel {
    lazy var searchViewModel = SearchViewModel(
        isSearchable: true,
        isActivated: true,
        placeholder: L10n.searchPlatform,
        delegate: self
    )
    var isBounceable: Bool = true
    var progress: Float?
    var rightButtonItem: AnyBarButtonItem? = .close
    let screenTitle: String? = L10n.stepOneOutOfThree
    var sections = [Section]()
    var platformDisplayed: [Platform] = []
    weak var containerDelegate: ContainerViewControllerDelegate?
    
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
            self.platformDisplayed = platforms
            self.sections = [SelectPlatformSection(platforms: platforms)]
        case .failure(let error):
            print(error)
            // TODO: Manage errors
        }
    }
    
    private func updateListOfPlatforms(with list: [Platform]) {
        self.sections = [SelectPlatformSection(platforms: list)]
    }
}

extension SelectPlatformViewModel: SearchViewModelDelegate {
    func updateSearch(with text: String) {
        guard text.count > .zero else {
            self.updateListOfPlatforms(with: self.platformDisplayed)
            return
        }
        
        let matchingPlatforms = self.platformDisplayed.filter({
            $0.title.localizedCaseInsensitiveContains(text)
        })
        print(matchingPlatforms)
        if !matchingPlatforms.isEmpty {
            self.updateListOfPlatforms(with: matchingPlatforms)
        } else {
            // TODO: Display empty state
        }
    }
}
