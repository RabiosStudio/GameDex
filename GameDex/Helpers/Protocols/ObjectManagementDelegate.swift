//
//  ObjectManagementDelegate.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/06/2024.
//

import Foundation

// sourcery: AutoMockable
protocol ObjectManagementDelegate: AnyObject {
    func edit(value: Any)
    func delete(value: Any)
}
