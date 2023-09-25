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
    
    // Password-entry textField
    private func setPasswordToggleImage(_ button: UIButton) {
        let imageName = isSecureTextEntry ? "lock" : "lock.slash"
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryColor
    }
    
    public func enableEntryVisibilityToggle() {
        let button = UIButton(type: .system)
        setPasswordToggleImage(button)
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        guard let size = button.imageView?.image?.size else { return }
        button.frame = CGRect(
            x: .zero,
            y: .zero,
            width: size.width,
            height: size.height
        )
        let container = UIView(
            frame: CGRect(
                x: .zero,
                y: .zero,
                width: size.width +
                DesignSystem.paddingSmall,
                height: size.height
            )
        )
        container.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: container.topAnchor),
            button.leftAnchor.constraint(equalTo: container.leftAnchor),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            button.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -DesignSystem.paddingSmall)
        ])
        self.rightViewMode = .always
        self.rightView = container
    }
    
    @IBAction private func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender)
    }
}
