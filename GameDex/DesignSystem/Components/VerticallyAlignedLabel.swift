//
//  VerticallyAlignedLabel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/10/2023.
//

import Foundation
import UIKit

class VerticallyAlignedUILabel: UILabel {
    
    enum Alignment {
        case top
        case bottom
    }
    
    var alignment: Alignment?
    
    override func drawText(in rect: CGRect) {
        var rect = rect
        if alignment == .top {
            rect.size.height = sizeThatFits(rect.size).height
        } else if alignment == .bottom {
            let height = sizeThatFits(rect.size).height
            rect.origin.y += rect.size.height - height
            rect.size.height = height
        }
        super.drawText(in: rect)
    }
}
