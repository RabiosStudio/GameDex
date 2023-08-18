//
//  NavigationController+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

extension UINavigationController {
       
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.prefersLargeTitles = false
        navigationBar.barTintColor = .primaryColor
        navigationBar.tintColor = .primaryColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
