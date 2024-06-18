//
//  AppReviewServiceImpl.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/06/2024.
//

import Foundation
import StoreKit

class AppReviewServiceImpl: AppReviewService {
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
