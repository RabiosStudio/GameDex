//
//  Section.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/08/2023.
//

import Foundation
import UIKit

class Section {
    var position: Int = 0
    var title: String?
    var cellsVM: [CellViewModel] = [CellViewModel]()
    
    func remove(index: Int) {
        self.cellsVM.remove(at: index)
    }
}
