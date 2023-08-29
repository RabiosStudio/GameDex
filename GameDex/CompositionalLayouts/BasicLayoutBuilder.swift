//
//  BasicLayoutBuilder.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

enum CellSize {
    case small
    case regular
    case big
    
    var value: CGFloat {
        switch self {
        case .small:
            return DesignSystem.sizeSmall
        case .regular:
            return DesignSystem.sizeRegular
        case .big:
            return DesignSystem.sizeBig
        }
    }
}

final class BasicLayoutBuilder: CollectionLayoutBuilder {
    
    private var cellSize: CellSize
    
    init(cellSize: CellSize) {
        self.cellSize = cellSize
    }
    
    func create() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeFull),
            heightDimension: .fractionalHeight(DesignSystem.fractionalSizeFull))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: DesignSystem.paddingSmall,
                                                     leading: DesignSystem.paddingSmall,
                                                     bottom: DesignSystem.paddingSmall,
                                                     trailing: DesignSystem.paddingSmall)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeFull),
            heightDimension: .absolute(cellSize.value)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
