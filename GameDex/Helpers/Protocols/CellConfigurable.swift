//
//  CellConfigurable.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation
import UIKit

protocol CellConfigurable: UIView {
    func configure(cellViewModel: CellViewModel)
    func cellTapped(cellViewModel: CellViewModel)
}

extension CellConfigurable {
    func cellTapped(cellViewModel: CellViewModel) {
        cellViewModel.cellTappedCallback?()
    }
}
