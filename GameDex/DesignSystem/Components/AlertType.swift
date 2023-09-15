//
//  AlertType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/09/2023.
//

import Foundation
import SwiftEntryKit

enum AlertType {
    case success
    case error
    case warning
    
    var color: EKColor {
        switch self {
        case .success:
            return EKColor(.systemGreen)
        case .error:
            return EKColor(.systemRed)
        case .warning:
            return EKColor(.systemRed)
        }
    }
    
    var image: UIImage {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle.fill")!
        case .error:
            return UIImage(systemName: "exclamationmark.circle.fill")!
        case .warning:
            return UIImage(systemName: "hand.raised")!
        }
    }
    
    var title: String {
        switch self {
        case .success:
            return L10n.successTitle
        case .error:
            return L10n.errorTitle
        case .warning:
            return L10n.warningTitle
        }
    }
}
