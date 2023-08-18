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
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.barTintColor = .primaryColor
        self.navigationBar.tintColor = .primaryColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryBackgroundColor
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
    }
    
    func setProgressBar() {
        let progressView: UIProgressView = {
            let view = UIProgressView(progressViewStyle: .bar)
            view.trackTintColor = .systemBlue
            view.progressTintColor = .primaryColor
            return view
        }()
    }
}
