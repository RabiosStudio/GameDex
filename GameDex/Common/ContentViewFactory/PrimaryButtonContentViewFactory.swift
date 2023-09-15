//
//  PrimaryButtonContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

final class PrimaryButtonContentViewFactory: ContentViewFactory {
    lazy var bottomView: UIView = {
        let continueButton = PrimaryButton(delegate: self.delegate, shouldEnable: true)
        continueButton.configure(
            viewModel: ButtonViewModel(
                title: self.buttonTitle
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
    
    init(delegate: PrimaryButtonDelegate?, buttonTitle: String) {
        self.delegate = delegate
        self.buttonTitle = buttonTitle
    }        
}
