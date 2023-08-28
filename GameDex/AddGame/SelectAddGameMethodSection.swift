//
//  SelectAddGameMethodSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectAddGameMethodSection: Section {
    
    override init() {
        super.init()
        self.position = 0
        
        let manualCellVM = ImageAndLabelCellViewModel(
            title: L10n.manually,
            description: L10n.manuallyDescription,
            imageName: Asset.form.name,
            navigationStyle: .push(
                controller: SelectPlatformScreenFactory().viewController
            )
        )
        self.cellsVM.append(manualCellVM)
        
        let scanCellVM = ImageAndLabelCellViewModel(
            title: L10n.scan,
            description: L10n.comingSoon,
            imageName: Asset.barcode.name,
            navigationStyle: nil
        )
        self.cellsVM.append(scanCellVM)
    }
}
