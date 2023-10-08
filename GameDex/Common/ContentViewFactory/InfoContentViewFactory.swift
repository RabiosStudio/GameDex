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
                text: self.infoText
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
