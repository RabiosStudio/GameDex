//
//  EmptyTextAndButton.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import UIKit

struct EmptyTextAndButton: EmptyReason {
    var customView: UIView?
    
    // Vertical Offset
    var verticalOffset: CGFloat {
        return tabBarOffset
    }
    
    let tabBarOffset: CGFloat
    
    // Title
    let customTitle: String
    
    var attributedTitle: NSAttributedString? {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryColor,
            NSAttributedString.Key.font: Typography.title1.font
        ]
        return NSAttributedString(string: self.customTitle,
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
        var attributes: [NSAttributedString.Key: Any] = [:]
        let font = Typography.callout.font
        let textColor = UIColor.primaryColor
        
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        
        return NSAttributedString(string: self.buttonTitle,
                                  attributes: attributes)
    }
    
    var completionBlock: (() -> Void)?
    
    let buttonTitle: String
    
    init(tabBarOffset: CGFloat,
         customTitle: String,
         descriptionText: String,
         image: UIImage,
         buttonTitle: String,
         completionBlock: (() -> Void)? ) {
        self.tabBarOffset = tabBarOffset
        self.customTitle = customTitle
        self.descriptionText = descriptionText
        self.image = image
        self.buttonTitle = buttonTitle
        self.completionBlock = completionBlock
    }
}
