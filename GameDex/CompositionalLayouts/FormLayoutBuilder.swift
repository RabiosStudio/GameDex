//
//  BasicLayoutBuilder.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit

final class FormLayoutBuilder: CollectionLayoutBuilder {
    
    func create() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeVeryBig),
            heightDimension: .fractionalHeight(DesignSystem.fractionalSizeVeryBig))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: DesignSystem.paddingSmall,
                                                     leading: DesignSystem.paddingSmall,
                                                     bottom: DesignSystem.paddingSmall,
                                                     trailing: DesignSystem.paddingSmall)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(DesignSystem.fractionalSizeVeryBig),
            heightDimension: .absolute(DesignSystem.sizeSmall)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
