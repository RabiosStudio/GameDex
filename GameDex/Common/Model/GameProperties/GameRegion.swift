//
//  Region.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import Foundation

enum GameRegion: String, CaseIterable {
    case pal
    case ntscu
    case ntscj
    case ntscc
    case unknown
    
    enum Constants {
        static let pal = "PAL"
        static let ntscu = "NTSC-U"
        static let ntscj = "NTSC-J"
        static let ntscc = "NTSC-C"
    }
    
    var value: String {
        switch self {
        case .pal:
            return Constants.pal
        case .ntscu:
            return Constants.ntscu
        case .ntscj:
            return Constants.ntscj
        case .ntscc:
            return Constants.ntscc
        case .unknown:
            return L10n.unknown
        }
    }
    
    static func getRawValue(value: String) -> Self {
        switch value {
        case Constants.pal:
            return .pal
        case Constants.ntscu:
            return .ntscu
        case Constants.ntscj:
            return .ntscj
        case Constants.ntscc:
            return .ntscc
        default:
            return .unknown
        }
    }
}
