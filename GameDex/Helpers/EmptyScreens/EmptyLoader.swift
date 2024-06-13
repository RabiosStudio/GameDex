//
//  EmptyLoader.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import UIKit
import NVActivityIndicatorView

struct EmptyLoader: EmptyReason {
    
    var completionBlock: (() -> Void)?
    
    var verticalOffset: CGFloat {
        return .zero
    }
    
    var customView: UIView? {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                           type: .pacman,
                                           color: .systemYellow,
                                           padding: 16)
        view.startAnimating()
        return view
    }
}
