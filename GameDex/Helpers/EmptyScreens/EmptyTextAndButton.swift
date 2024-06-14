//
//  EmptyTextAndButton.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import UIKit

struct EmptyTextAndButton: EmptyReason {
    // Vertical Offset
    var verticalOffset: CGFloat {
        return .zero
    }
    
    // Title
    let customTitle: String?
    
    var attributedTitle: NSAttributedString? {
        guard let customTitle = self.customTitle else { return nil }
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryColor,
            NSAttributedString.Key.font: Typography.title1.font
        ]
        return NSAttributedString(string: customTitle,
                                  attributes: attributes)
    }
    
    // Description
    var descriptionText: String?
    
    var attributedDescription: NSAttributedString? {
        guard let description = self.descriptionText else { return nil }
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryColor,
            NSAttributedString.Key.font: Typography.title3.font
        ]
        return NSAttributedString(string: description,
                                  attributes: attributes)
    }
    
    var image: UIImage?
    
    var attributedButtonTitle: NSAttributedString? {
        guard let buttonTitle = self.buttonTitle else { return nil }
        var attributes: [NSAttributedString.Key: Any] = [:]
        let font = Typography.callout.font
        let textColor = UIColor.primaryColor
        
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        return NSAttributedString(string: buttonTitle,
                                  attributes: attributes)
    }
    
    var completionBlock: (() -> Void)?
    
    let buttonTitle: String?
    
    init(
        customTitle: String?,
        descriptionText: String?,
        image: UIImage?,
        buttonTitle: String?,
        completionBlock: (() -> Void)?
    ) {
        self.customTitle = customTitle
        self.descriptionText = descriptionText
        self.image = image
        self.buttonTitle = buttonTitle
        self.completionBlock = completionBlock
    }
}
