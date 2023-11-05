//
//  AlertView.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 11/09/2023.
//

import Foundation
import UIKit
import SwiftEntryKit

// sourcery: AutoMockable
protocol AlertDisplayerDelegate: AnyObject {
    func didTapOkButton() async
}

// sourcery: AutoMockable
protocol AlertDisplayer {
    var alertDelegate: AlertDisplayerDelegate? { get set }
    func presentTopFloatAlert(parameters: AlertViewModel)
    func presentBasicAlert(parameters: AlertViewModel)
}

class AlertDisplayerImpl: AlertDisplayer {
    
    weak var alertDelegate: AlertDisplayerDelegate?
    
    func presentTopFloatAlert(parameters: AlertViewModel) {
        DispatchQueue.main.async {
            
            var attributes: EKAttributes = .topFloat
            
            attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: parameters.alertType.color)
            attributes.displayDuration = 1.5
            attributes.entryInteraction = .dismiss
            attributes.screenInteraction = .dismiss
            
            let titleLabel = EKProperty.LabelContent(
                text: parameters.alertType.title,
                style: EKProperty.LabelStyle(
                    font: .systemFont(
                        ofSize: Typography.title3.systemSize,
                        weight: .semibold
                    ), color: EKColor(.white)
                )
            )
            let descriptionLabel = EKProperty.LabelContent(
                text: parameters.description,
                style: EKProperty.LabelStyle(
                    font: .systemFont(
                        ofSize: Typography.headline.systemSize,
                        weight: .regular
                    ), color: EKColor(.white)
                )
            )
            let image = EKProperty.ImageContent(
                image: parameters.alertType.image,
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
    
    func presentBasicAlert(parameters: AlertViewModel) {
        DispatchQueue.main.async {
            let displayMode = EKAttributes.DisplayMode.inferred
            var attributes: EKAttributes = .centerFloat
            attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.5, alpha: 0.5)))
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
            attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: EKColor(.primaryBackgroundColor))
            attributes.displayDuration = .infinity
            attributes.windowLevel = .normal
            attributes.position = .center
            attributes.entryInteraction = .absorbTouches
            attributes.screenInteraction = .dismiss
            
            let title = EKProperty.LabelContent(
                text: parameters.alertType.title,
                style: EKProperty.LabelStyle(
                    font: .systemFont(
                        ofSize: Typography.title2.systemSize,
                        weight: .semibold
                    ), color: EKColor(.secondaryColor),
                    alignment: .center,
                    displayMode: displayMode
                )
            )
            let description = EKProperty.LabelContent(
                text: parameters.description,
                style: EKProperty.LabelStyle(
                    font: .systemFont(
                        ofSize: Typography.title3.systemSize,
                        weight: .regular
                    ), color: EKColor(.secondaryColor),
                    alignment: .center,
                    displayMode: displayMode
                )
            )
            
            let image = EKProperty.ImageContent(
                image: parameters.alertType.image,
                displayMode: displayMode,
                size: CGSize(
                    width: DesignSystem.sizeVerySmall,
                    height: DesignSystem.sizeVerySmall
                ),
                tint: parameters.alertType.color,
                contentMode: .scaleAspectFill
            )
            
            let simpleMessage = EKSimpleMessage(
                image: image,
                title: title,
                description: description
            )
            let buttonFont = Typography.callout.font
            let closeButtonLabelStyle = EKProperty.LabelStyle(
                font: buttonFont,
                color: EKColor(.secondaryColor),
                displayMode: displayMode
            )
            let closeButtonLabel = EKProperty.LabelContent(
                text: L10n.cancel,
                style: closeButtonLabelStyle
            )
            let closeButton = EKProperty.ButtonContent(
                label: closeButtonLabel,
                backgroundColor: .clear,
                highlightedBackgroundColor: EKColor(.secondaryBackgroundColor),
                displayMode: displayMode
            ) {
                SwiftEntryKit.dismiss()
            }
            
            let okButtonLabelStyle = EKProperty.LabelStyle(
                font: buttonFont,
                color: EKColor(.primaryBackgroundColor),
                displayMode: displayMode
            )
            let okButtonLabel = EKProperty.LabelContent(
                text: L10n.confirm,
                style: okButtonLabelStyle
            )
            let okButton = EKProperty.ButtonContent(
                label: okButtonLabel,
                backgroundColor: EKColor(.primaryColor),
                highlightedBackgroundColor: EKColor(.secondaryBackgroundColor),
                displayMode: displayMode
            ) {
                Task {
                    await self.alertDelegate?.didTapOkButton()
                }
            }
            
            // Generate the content
            let buttonsBarContent = EKProperty.ButtonBarContent(
                with: closeButton, okButton,
                separatorColor: EKColor(.secondaryBackgroundColor),
                displayMode: displayMode,
                expandAnimatedly: false
            )
            let alertMessage = EKAlertMessage(
                simpleMessage: simpleMessage,
                buttonBarContent: buttonsBarContent
            )
            let contentView = EKAlertMessageView(with: alertMessage)
            SwiftEntryKit.display(entry: contentView, using: attributes)
        }
    }
}
