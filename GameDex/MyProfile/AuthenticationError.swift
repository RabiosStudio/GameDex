//
//  AuthenticationError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation

public enum AuthenticationError: Error {
    case loginError
    case createAccountError
    case logoutError
    case saveUserDataError
    case deleteUserError
    case passwordResetEmailError
}
