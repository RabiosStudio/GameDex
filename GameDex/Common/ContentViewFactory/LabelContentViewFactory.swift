//
//  LabelContentViewFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/06/2024.
//

import Foundation

import UIKit

final class LabelContentViewFactory: ContentViewFactory {
    
    let position: Position
    private let text: String
    
    lazy var contentView: UIView = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = self.text
        view.numberOfLines = .zero
        view.textColor = .secondaryColor
        view.font = Typography.headline.font
        return view
    }()
    
    init(text: String, position: Position) {
        self.text = text
        self.position = position
    }
}
