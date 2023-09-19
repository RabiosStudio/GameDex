//
//  GameDetailsViewModelDelegate.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/09/2023.
//

import Foundation

// sourcery: AutoMockable
protocol GameDetailsViewModelDelegate: AnyObject {
    func reloadCollection()
}
