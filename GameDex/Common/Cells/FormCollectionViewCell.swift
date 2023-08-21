//
//  FormCollectionViewCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit
import DTTextField

final class FormCollectionViewCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var textField: DTTextField = {
        let textField = DTTextField()
        textField.floatPlaceholderActiveColor = .black
        textField.placeholderColor = .systemGray
        textField.textColor = .black
        textField.errorTextColor = .primaryColor
        textField.paddingYErrorLabel = DesignSystem.paddingVerySmall
        textField.animateFloatPlaceholder = true
        textField.hideErrorWhenEditing = true
        textField.floatingDisplayStatus = .defaults
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .primaryBackgroundColor
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
        if cellVM.firstResponder {
        self.textField.becomeFirstResponder()
        }
        self.textField.placeholder = cellVM.title
        self.textField.errorMessage = cellVM.title + L10n.isRequired
    }
}

// MARK: TextFieldDelegate

extension FormCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
