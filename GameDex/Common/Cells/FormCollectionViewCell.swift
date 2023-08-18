//
//  FormCollectionViewCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit
import DTTextField

class FormCollectionViewCell: UICollectionViewCell, CellConfigurable {
    
    private let textField: DTTextField = {
        let textField = DTTextField()
        textField.paddingYErrorLabel = DesignSystem.paddingVerySmall
        textField.animateFloatPlaceholder = true
        textField.placeholderColor = .systemGray
        textField.hideErrorWhenEditing = true
        textField.errorTextColor = .primaryColor
        textField.floatingDisplayStatus = .defaults
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.topAnchor),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textField.placeholder = nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? FormCollectionCellViewModel else {
            return
        }
        self.textField.placeholder = cellVM.title
        self.textField.errorMessage = cellVM.title + L10n.isRequired
    }
}
