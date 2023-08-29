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

enum CellSpacing {
    case none
    case small
    case regular
    
    var value: CGFloat {
        switch self {
        case .none:
            return .zero
        case .small:
            return DesignSystem.paddingSmall
        case .regular:
            return DesignSystem.paddingRegular
        }
    }
}

final class BasicLayoutBuilder: CollectionLayoutBuilder {
    
    private var cellSize: CellSize
    private var cellHorizontalSpacing: CellSpacing
    private var cellVerticalSpacing: CellSpacing
    
    init(cellSize: CellSize, cellHorizontalSpacing: CellSpacing, cellVerticalSpacing: CellSpacing) {
        self.cellSize = cellSize
        self.cellHorizontalSpacing = cellHorizontalSpacing
        self.cellVerticalSpacing = cellVerticalSpacing
    }
    
    func create() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeFull),
            heightDimension: .fractionalHeight(DesignSystem.fractionalSizeFull))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: cellVerticalSpacing.value,
                                                     leading: cellHorizontalSpacing.value,
                                                     bottom: cellVerticalSpacing.value,
                                                     trailing: cellHorizontalSpacing.value)
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
