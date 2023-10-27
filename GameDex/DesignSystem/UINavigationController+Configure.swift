//
//  NavigationController+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

extension UINavigationController {
    func configure() {
        DispatchQueue.main.async {
            self.navigationBar.prefersLargeTitles = false
            self.navigationBar.barTintColor = .primaryColor
            self.navigationBar.tintColor = .primaryColor
            self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
                title: "",
                style: .plain,
                target: nil,
                action: nil
            )
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .primaryBackgroundColor
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
        }
    }
}
