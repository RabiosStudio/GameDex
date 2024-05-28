//
//  PrimaryButtonContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

final class PrimaryButtonContentViewFactory: ContentViewFactory {
    let position: Position
    
    lazy var contentView: UIView = {
        let continueButton = PrimaryButton(delegate: self.delegate)
        continueButton.configure(
            viewModel: ButtonViewModel(
                isEnabled: shouldEnable,
                title: self.buttonTitle,
                backgroundColor: .secondaryColor
            )
        )
        continueButton.layoutMargins = UIEdgeInsets(
            top: DesignSystem.paddingLarge,
            left: DesignSystem.paddingLarge,
            bottom: DesignSystem.paddingLarge,
            right: DesignSystem.paddingLarge
        )
        return continueButton
    }()
    weak var delegate: PrimaryButtonDelegate?
    
    private let buttonTitle: String
    private let shouldEnable: Bool
    
    init(
        delegate: PrimaryButtonDelegate?,
        buttonTitle: String,
        shouldEnable: Bool,
        position: Position
    ) {
        self.delegate = delegate
        self.buttonTitle = buttonTitle
        self.shouldEnable = shouldEnable
        self.position = position
    }        
}
