//
//  AddGameFormType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 11/09/2023.
//

import Foundation

enum AddGameFormType: Equatable {
    case yearOfAcquisition
    case gameCondition(PickerViewModel)
    case gameCompleteness(PickerViewModel)
    case gameRegion(PickerViewModel)
    case storageArea
    case rating
    case notes
}
