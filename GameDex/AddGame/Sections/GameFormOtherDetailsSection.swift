//
//  GameFormOtherDetailsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class GameFormOtherDetailsSection: Section {
    
    override init() {
        super.init()
        self.position = 2
        
        let otherDetails = TextViewCellViewModel(title: L10n.otherDetails)
        self.cellsVM.append(otherDetails)
    }
}
