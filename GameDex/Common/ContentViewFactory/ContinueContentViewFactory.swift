//
//  NextContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

final class ContinueContentViewFactory: ContentViewFactory {
    lazy var bottomView: UIView = {
        let continueButton = PrimaryButton(delegate: self.delegate)
        continueButton.configure(
            viewModel: ButtonViewModel(
                title: L10n.continue,
                buttonStyle: .regular
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
    
    init(delegate: PrimaryButtonDelegate?) {
        self.delegate = delegate
    }        
}
