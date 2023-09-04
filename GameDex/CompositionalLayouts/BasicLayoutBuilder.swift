//
//  BasicLayoutBuilder.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation
import UIKit

final class BasicLayoutBuilder: CollectionLayoutBuilder {
    
    private let cellLayout: CellLayout
    
    init(cellLayout: CellLayout) {
        self.cellLayout = cellLayout
    }
    
    func create() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeFull),
            heightDimension: .fractionalHeight(DesignSystem.fractionalSizeFull))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: cellLayout.verticalSpacing.value,
                                                     leading: cellLayout.horizontalSpacing.value,
                                                     bottom: cellLayout.verticalSpacing.value,
                                                     trailing: cellLayout.horizontalSpacing.value)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeFull),
            heightDimension: .absolute(cellLayout.size.value)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
