//
//  InfoContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/10/2023.
//

import Foundation
import UIKit

final class InfoContentViewFactory: ContentViewFactory {
    lazy var contentView: UIView = {
        let view = InfoView()
        view.configure(
            viewModel: InfoViewModel(
                text: self.infoText
            )
        )
        view.layoutMargins = UIEdgeInsets(
            top: DesignSystem.paddingLarge,
            left: DesignSystem.paddingLarge,
            bottom: DesignSystem.paddingLarge,
            right: DesignSystem.paddingLarge
        )
        return view
    }()
    
    private let infoText: String
    
    init(infoText: String) {
        self.infoText = infoText
    }
}
