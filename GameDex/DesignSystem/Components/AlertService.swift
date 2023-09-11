//
//  AlertService.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 11/09/2023.
//

import Foundation
import UIKit
import SwiftEntryKit

enum AlertType {
    case success
    case error
    
    var color: EKColor {
        switch self {
        case .success:
            return EKColor(.systemGreen)
        case .error:
            return EKColor(.systemRed)
        }
    }
    
    var image: UIImage {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle.fill")!
        case .error:
            return UIImage(systemName: "exclamationmark.circle.fill")!
        }
    }
}

class AlertService {
    
    static let shared = AlertService()
    
    func presentAlert(title: String, description: String, type: AlertType) {
        
        var attributes: EKAttributes = .topFloat
        
        attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: type.color)
        attributes.displayDuration = 3
        attributes.entryInteraction = .dismiss
        attributes.screenInteraction = .dismiss
        
        let titleLabel = EKProperty.LabelContent(
            text: title,
            style: EKProperty.LabelStyle(
                font: .systemFont(
                    ofSize: Typography.title3.systemSize,
                    weight: .semibold
                ), color: EKColor(.white)
            )
        )
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: EKProperty.LabelStyle(
                font: .systemFont(
                    ofSize: Typography.headline.systemSize,
                    weight: .regular
                ), color: EKColor(.white)
            )
        )
        let image = EKProperty.ImageContent(
            image: type.image,
            size: CGSize(
                width: DesignSystem.sizeTiny,
                height: DesignSystem.sizeTiny
            ),
            tint: EKColor(.white),
            contentMode: .scaleAspectFill
        )
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: titleLabel,
            description: descriptionLabel
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let entry = EKNotificationMessageView(with: notificationMessage)
        
        SwiftEntryKit.display(entry: entry, using: attributes)
    }
}
