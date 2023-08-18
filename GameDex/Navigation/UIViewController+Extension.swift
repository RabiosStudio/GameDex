//
//  UIViewController+Controller.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

enum ScreenSize {
    case half
    case full
}

extension UIViewController {
    
    var presentedController: UIViewController? {
        return self.presentedViewController
    }
    
    var navController: NavController? {
        return self.navigationController
    }
    
    func present(controller: UIViewController, animated: Bool, screenSize: ScreenSize, completion: @escaping () -> ()) {
        if #available(iOS 15.0, *) {
            let presentationController = controller.presentationController as? UISheetPresentationController
            switch screenSize {
            case .full:
                presentationController?.detents = [.large()]
            case .half:
                presentationController?.detents = [.medium()]
            }
        }
        self.present(
            controller,
            animated: animated,
            completion: completion
        )
    }
    
    func dismissController(animated: Bool, completion: @escaping () -> ()) {
        self.dismiss(
            animated: animated,
            completion: completion
        )
    }
}
