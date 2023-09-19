//
//  DTTextField+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 07/09/2023.
//

import Foundation
import DTTextField

extension DTTextField {
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard self.keyboardType != .asciiCapable || self.inputView != nil else {
            return super.canPerformAction(action, withSender: sender)
        }
        
        return action == #selector(UIResponderStandardEditActions.paste(_:)) ?
        false : super.canPerformAction(action, withSender: sender)
    }
    
    func configure() {
        self.floatPlaceholderColor = .placeholderColor
        self.floatPlaceholderActiveColor = .placeholderColor
        self.placeholderColor = .placeholderColor
        self.textColor = .secondaryColor
        self.tintColor = .primaryColor
        self.dtLayer.backgroundColor = UIColor.primaryBackgroundColor.cgColor
        self.errorTextColor = .primaryColor
        self.paddingYErrorLabel = DesignSystem.paddingSmall
        self.animateFloatPlaceholder = true
        self.hideErrorWhenEditing = true
        self.floatingDisplayStatus = .defaults
    }
}
