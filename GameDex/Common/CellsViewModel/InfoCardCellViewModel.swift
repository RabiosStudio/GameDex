//
//  InfoCardCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class InfoCardCellViewModel: CellViewModel {
    
    var cellClass: AnyClass = InfoCardCell.self
    var indexPath: IndexPath?
    var title: String
    var description: String
    var imageName: String
    var navigationStyle: NavigationStyle?
    
    init(
        title: String,
        description: String,
        imageName: String,
        navigationStyle: NavigationStyle?
    ) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.navigationStyle = navigationStyle
    }
}
