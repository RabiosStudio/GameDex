//
//  NavigationController.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//
//
import Foundation
import UIKit

protocol NavController: UIViewController {
    
    func push(controller: UIViewController, animated: Bool)
    func popController(animated: Bool)
    
}

extension UINavigationController: NavController {
    
    func push(controller: UIViewController, animated: Bool) {
        self.pushViewController(controller, animated: animated)
    }
    
    func popController(animated: Bool) {
        self.popViewController(animated: animated)
    }
}
