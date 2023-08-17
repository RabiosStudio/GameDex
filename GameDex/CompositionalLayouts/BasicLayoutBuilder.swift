//
//  BasicLayoutBuilder.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

class BasicLayoutBuilder: CollectionLayoutBuilder {
    
    func create() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4,
                                                     leading: 4,
                                                     bottom: 4,
                                                     trailing: 4)
        
        let groupLayoutSize: CGSize = CGSize(
            width: 1.0,
            height: 0.15
        )
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupLayoutSize.width),
                                               heightDimension: .fractionalHeight(groupLayoutSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
