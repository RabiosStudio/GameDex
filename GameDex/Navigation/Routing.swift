//
//  Routing.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

protocol ScreenFactory {
    var viewController: UIViewController { get }
}

class Routing: NSObject, Navigator {
    
    // MARK: - Navigator
    public static let shared = Routing()
    
    private override init() {}
    
    var lastNavigationStyle: NavigationStyle?
    
    func visibleViewController() -> UIViewController? {
        guard let window = UIApplication.shared.delegate?.window  else {
            return nil
        }
        return self.visibleViewController(window!.rootViewController)
    }
    
    func visibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        if let rootNavigationController = rootViewController as? UINavigationController {
            let lastViewController: UIViewController? = rootNavigationController.viewControllers.last
            return self.visibleViewController(lastViewController)
        } else if let rootTabBarController = rootViewController as? UITabBarController {
            let selectedViewController: UIViewController? = rootTabBarController.selectedViewController
            return visibleViewController(selectedViewController)
        }
        
        if rootViewController?.presentedController == nil {
            return rootViewController
        } else {
            return self.visibleViewController(rootViewController?.presentedController)
        }
    }
    
    @discardableResult func route(navigationStyle: NavigationStyle,
                                  fromController: UIViewController? = nil,
                                  animated: Bool = true) -> Navigator {
        var fromVC = fromController
        
        if fromVC == nil {
            fromVC = self.visibleViewController()
        }
        
        // Navigate on main thread to avoid crashes
        DispatchQueue.main.async(execute: {() -> Void in
            switch navigationStyle {
            case .push(let viewControllerToDisplay):
                print("push \(viewControllerToDisplay)")
            case .pop:
                print("pop")
            case let .present(viewControllerToDisplay, screenSize, completionBlock):
                fromVC?.present(controller: viewControllerToDisplay,
                                animated: animated,
                                screenSize: screenSize,
                                completion: {() -> Void in
                    completionBlock?()
                })
                
            case .selectTab(let index, let completionBlock):
                print("selectTab \(index) with completionBlock \(String(describing: completionBlock))")
            case .dismiss(let completionBlock):
                print("dismiss with completionBlock \(String(describing: completionBlock))")
            }
        })
        
        self.lastNavigationStyle = navigationStyle
        return self
    }
}
