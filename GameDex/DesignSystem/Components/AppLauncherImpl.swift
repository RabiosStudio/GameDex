//
//  AppLauncherImpl.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/10/2023.
//

import Foundation
import UIKit

class AppLauncherImpl: AppLauncher {
    func canOpenURL(_ url: URL) -> Bool {
        return UIApplication.shared.canOpenURL(url)
    }
    
    func open(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    func createEmailUrl(to: String) -> URL? {
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)")
        let mailUrl = URL(string: "mailto:\(to)")
        
        if let mailUrl = mailUrl, self.canOpenURL(mailUrl) {
            return mailUrl
        } else if let gmailUrl = gmailUrl, self.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, self.canOpenURL(outlookUrl) {
            return outlookUrl
        }
        return nil
    }
}
