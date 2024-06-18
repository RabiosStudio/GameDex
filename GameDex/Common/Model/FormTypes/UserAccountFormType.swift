//
//  UserAccountFormType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import UIKit

enum UserAccountFormType: FormType, Equatable {
    
    case email
    case password
    case collection(PickerViewModel)
    
    var keyboardType: UIKeyboardType? {
        switch self {
        case .email:
            return .emailAddress
        case .password:
            return .asciiCapable
        case .collection:
            return nil
        }
    }
    
    var enableSecureTextEntry: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
    
    var inputPickerViewModel: PickerViewModel? {
        switch self {
        case let .collection(pickerVM):
            return pickerVM
        default:
            return nil
        }
    }
}
