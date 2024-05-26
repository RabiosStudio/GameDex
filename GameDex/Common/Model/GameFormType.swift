//
//  GameFormType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 11/09/2023.
//

import Foundation
import UIKit

enum GameFormType: FormType, Equatable {
    case yearOfAcquisition(PickerViewModel?)
    case gameCondition(PickerViewModel)
    case gameCompleteness(PickerViewModel)
    case gameRegion(PickerViewModel)
    case storageArea(PickerViewModel?)
    case rating
    case notes
    
    var keyboardType: UIKeyboardType? {
        switch self {
        case .storageArea(nil), .notes:
            return .asciiCapable
        case .yearOfAcquisition(nil):
            return .asciiCapableNumberPad
        default:
            return nil
        }
    }
    
    var enableSecureTextEntry: Bool {
        return false
    }
    
    var inputPickerViewModel: PickerViewModel? {
        switch self {
        case let .gameCompleteness(pickerVM), let .gameCondition(pickerVM), let .gameRegion(pickerVM), let .yearOfAcquisition(pickerVM?), let .storageArea( pickerVM?):
            return pickerVM
        default:
            return nil
        }
    }
}
