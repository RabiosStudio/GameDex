//
//  GameFilterFormType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 26/05/2024.
//

import Foundation
import UIKit

enum GameFilterFormType: FormType, Equatable {
    case isPhysical(PickerViewModel)
    case acquisitionYear(PickerViewModel)
    case gameCondition(PickerViewModel)
    case gameCompleteness(PickerViewModel)
    case gameRegion(PickerViewModel)
    case storageArea(PickerViewModel)
    case rating
    
    var keyboardType: UIKeyboardType? {
        switch self {
        default:
            return nil
        }
    }
    
    var enableSecureTextEntry: Bool {
        return false
    }
    
    var inputPickerViewModel: PickerViewModel? {
        switch self {
        case let .gameCompleteness(pickerVM), let .gameCondition(pickerVM), let .gameRegion(pickerVM), let .acquisitionYear(pickerVM), let .storageArea(pickerVM), let .isPhysical(pickerVM):
            return pickerVM
        case .rating:
            return nil
        }
    }
}
