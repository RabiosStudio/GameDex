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
    
    var keyboardType: UIKeyboardType? {
        switch self {
        case .email:
            return .emailAddress
        case .password:
            return .asciiCapable
        }
    }
    
    var enableSecureTextEntry: Bool {
        switch self {
        case .email:
            return false
        case .password:
            return true
        }
    }
    
    var inputPickerViewModel: PickerViewModel? {
        return nil
    }
}
