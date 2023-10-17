//
//  AppLauncher.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/10/2023.
//

import Foundation
import UIKit

protocol AppLauncher {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)
    func createEmailUrl(to: String) -> URL?
}
