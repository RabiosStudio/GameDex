//
//  FormDelegate.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/06/2024.
//

import Foundation

// sourcery: AutoMockable
protocol FormDelegate: AnyObject {
    func didUpdate(value: Any, for type: FormType)
}

// sourcery: AutoMockable
protocol GameFormDelegate: FormDelegate {
    func refreshSectionsDependingOnGameFormat()
}
