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
        
        DispatchQueue.main.async {
            if fromVC == nil {
                fromVC = self.visibleViewController()
            }
        }
        
        // Navigate on main thread to avoid crashes
        DispatchQueue.main.async(execute: {() -> Void in
            switch navigationStyle {
            case .push(let screenFactory):
                var fromNavigationController: UINavigationController? = fromController as? UINavigationController
                
                if let navigationController = fromVC?.navController as? UINavigationController {
                    fromNavigationController = navigationController
                }
                fromNavigationController?.pushViewController(
                    screenFactory.viewController,
                    animated: animated
                )
            case .pop:
                print("pop")
            case let .present(screenFactory, screenSize, completionBlock):
                let navigationController = UINavigationController(rootViewController: screenFactory.viewController)
                fromVC?.present(controller: navigationController,
                                animated: animated,
                                screenSize: screenSize,
                                completion: {() -> Void in
                    completionBlock?()
                })
            case .selectTab(let index, let completionBlock):
                guard let navigationController = fromVC as? UINavigationController ?? fromVC?.navController as? UINavigationController,
                      let tabBarController = navigationController.tabBarController else {
                    return
                }
                
                tabBarController.selectedIndex = index
                completionBlock?()
            case .dismiss(let completionBlock):
                fromVC?.dismissController(animated: animated,
                                          completion: {() -> Void in
                    completionBlock?()
                })
            case let .url(appURL, appLauncher, alertDisplayer, alertViewModel):
                if appLauncher.canOpenURL(appURL) {
                    appLauncher.open(appURL)
                } else {
                    alertDisplayer.presentTopFloatAlert(parameters: alertViewModel)
                }
            }
        })
        
        self.lastNavigationStyle = navigationStyle
        return self
    }
}
