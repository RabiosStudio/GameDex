//
//  InfoContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/10/2023.
//

import Foundation
import UIKit

final class InfoContentViewFactory: ContentViewFactory {
    
    let position: Position
    
    lazy var contentView: UIView = {
        let view = InfoView()
        view.configure(
            viewModel: InfoViewModel(
                text: self.infoText,
                textAlignment: .left,
                numberOfLines: .zero,
                textColor: .white,
                backgroundColor: .systemOrange,
                alpha: DesignSystem.opaque,
                font: Typography.title3bold.font,
                image: UIImage(systemName: "info.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                cornerRadius: DesignSystem.cornerRadiusBig
            )
        )
        return view
    }()
        
    private let infoText: String
    
    init(infoText: String, position: Position) {
        self.infoText = infoText
        self.position = position
    }
}
