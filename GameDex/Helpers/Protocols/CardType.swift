//
//  CardType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

protocol CardType {
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var image: UIImage? { get }
    var height: CGFloat { get }
}
