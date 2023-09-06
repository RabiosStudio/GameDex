//
//  Equatables.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
@testable import GameDex

extension Platform: Equatable {
    public static func == (lhs: Platform, rhs: Platform) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title
    }
}

extension FormTextFieldType: Equatable {
    public static func == (lhs: FormTextFieldType, rhs: FormTextFieldType) -> Bool {
        return true
    }
}
