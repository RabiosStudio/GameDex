//
//  FormType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/09/2023.
//

import Foundation
import UIKit

protocol FormType {
    var keyboardType: UIKeyboardType? { get }
    var inputPickerViewModel: PickerViewModel? { get }
}
