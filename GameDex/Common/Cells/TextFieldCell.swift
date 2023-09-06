//
//  TextFieldCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit
import DTTextField

enum FormTextFieldType: CaseIterable {
    case text
    case numbers
}

final class TextFieldCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var textField: DTTextField = {
        let textField = DTTextField()
        textField.floatPlaceholderActiveColor = .secondaryColor
        textField.placeholderColor = .systemGray
        textField.textColor = .secondaryColor
        textField.tintColor = .primaryColor
        textField.dtLayer.backgroundColor = UIColor.primaryBackgroundColor.cgColor
        textField.errorTextColor = .primaryColor
        textField.paddingYErrorLabel = DesignSystem.paddingSmall
        textField.animateFloatPlaceholder = true
        textField.hideErrorWhenEditing = true
        textField.floatingDisplayStatus = .defaults
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var cellVM: TextFieldCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .primaryBackgroundColor
        contentView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.textField.dtLayer.backgroundColor = UIColor.primaryBackgroundColor.cgColor
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
        guard let cellVM = cellViewModel as? TextFieldCellViewModel else {
            return
        }
        self.cellVM = cellVM
        
        switch cellVM.textFieldType {
        case .numbers:
            self.textField.keyboardType = .decimalPad
            self.textField.autocorrectionType = .no
        default:
            self.textField.autocorrectionType = .no
        }
        if cellVM.shouldActiveTextField {
            self.textField.becomeFirstResponder()
        }
        self.textField.placeholder = cellVM.placeholder
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {}
    
    private func storeEntry(cellViewModel: CellViewModel?, with text: String) {
        guard let cellVM = self.cellVM else {
            return
        }
        cellVM.value = text
    }
}

// MARK: TextFieldDelegate

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = self.textField.text else {
            return
        }
        self.storeEntry(cellViewModel: self.cellVM, with: text)
    }
}
