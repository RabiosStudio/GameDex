//
//  Filter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/05/2024.
//

import Foundation

protocol Filter {
    associatedtype U
    
    var keyPath: PartialKeyPath<U> { get }
    func value<T>() -> T?
}
