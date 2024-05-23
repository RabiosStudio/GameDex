//
//  Filter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/05/2024.
//

import Foundation

protocol Filter<Item> {
    associatedtype Item
    var keyPath: PartialKeyPath<Item> { get }
    func value<ValueType>() -> ValueType?
}
