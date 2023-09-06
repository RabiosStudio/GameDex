//
//  TextFieldCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit
import DTTextField

enum FormTextFieldType {
    case year
    case text
    case price
    case picker(PickerViewModel)
}

final class TextFieldCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var textField: DTTextField = {
        let textField = DTTextField()
        textField.floatPlaceholderActiveColor = .secondaryColor
        textField.placeholderColor = .secondaryColor
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
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: self.contentView.frame.size.width,
                    height: DesignSystem.sizeBig
                )
            )
        )
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private var cellVM: TextFieldCellViewModel?
    private var pickerData: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .primaryBackgroundColor
        contentView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.textField.dtLayer.backgroundColor = UIColor.primaryBackgroundColor.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textField.placeholder = nil
        self.textField.inputView = nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? TextFieldCellViewModel else {
            return
        }
        self.cellVM = cellVM
        
        switch cellVM.textFieldType {
        case .text:
            self.textField.keyboardType = .asciiCapable
        case .year:
            self.textField.keyboardType = .asciiCapableNumberPad
        case .price:
            self.textField.keyboardType = .decimalPad
            
        case .picker(let pickerVM):
            self.pickerData = pickerVM.data
            self.textField.inputView = pickerView
        }
        self.textField.autocorrectionType = .no
        self.textField.placeholder = cellVM.placeholder
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {}
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.topAnchor),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
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

// MARK: - PickerView DataSource

extension TextFieldCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = self.pickerData else {
            return .zero
        }
        return data.count
    }
}

// MARK: - PickerView Delegate

extension TextFieldCell: UIPickerViewDelegate {
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = self.pickerData else {
            return nil
        }
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = self.pickerData else {
            return
        }
        self.textField.text = data[row]
    }
}
