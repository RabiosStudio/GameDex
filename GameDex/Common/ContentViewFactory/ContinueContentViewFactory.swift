//
//  NextContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

class ContinueContentViewFactory: ContentViewFactory {
    weak var delegate: AddGameStepOneVMDelegate?
    lazy var bottomView: UIView = {
        let continueButton = PrimaryButton()
        continueButton.configure(
            viewModel: ButtonViewModel(
                title: L10n.continue,
                buttonStyle: .regular
            )
        )
        continueButton.addTarget(
            self,
            action: #selector(didTapPrimaryButton(_:)),
            for: .touchUpInside
        )
        continueButton.layoutMargins = UIEdgeInsets(
            top: DesignSystem.paddingLarge,
            left: DesignSystem.paddingLarge,
            bottom: DesignSystem.paddingLarge,
            right: DesignSystem.paddingLarge
        )
        return continueButton
    }()
    
    init(delegate: AddGameStepOneVMDelegate?) {
        self.delegate = delegate
    }
    
    @objc private func didTapPrimaryButton(_ sender: PrimaryButton) {
        self.delegate?.didTapPrimaryButton()
    }
}
