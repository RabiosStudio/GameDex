//
//  TextFieldCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit
import DTTextField

final class TextFieldCell: UICollectionViewCell, CellConfigurable {
    var didTapClearButton = false
    private lazy var textField: DTTextField = {
        let textField = DTTextField()
        textField.configure()
        textField.clearButtonMode = .always
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
    private var pickerData: [[String]]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(textField)
        self.contentView.backgroundColor = .clear
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
        self.textField.inputView = nil
        self.textField.isSecureTextEntry = false
        self.textField.rightView = nil
        self.textField.text = nil
        self.pickerData = nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? TextFieldCellViewModel else {
            return
        }
        self.cellVM = cellVM
        self.textField.placeholder = cellVM.placeholder
        self.textField.text = cellVM.value

        var showCancelButton = true
        if let keyboardType = cellVM.formType.keyboardType {
            self.textField.keyboardType = keyboardType
        } else if let inputVM = cellVM.formType.inputPickerViewModel {
            self.pickerData = inputVM.data
            self.textField.inputView = pickerView
            showCancelButton = false
        }
        
        if cellVM.formType.enableSecureTextEntry {
            self.textField.isSecureTextEntry = true
            self.textField.enableEntryVisibilityToggle()
        }
        
        self.textField.inputAccessoryView = KeyboardAccessoryView(delegate: self, showCancelButton: showCancelButton)
        self.textField.autocorrectionType = .no
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.topAnchor),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func storeEntry(with text: String?) {
        guard let text else {
            self.cellVM?.value = nil
            return
        }
        self.cellVM?.value = text.isEmpty ? nil : text
    }
}

// MARK: TextFieldDelegate

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        self.storeEntry(with: text)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let cellVM = self.cellVM,
              self.didTapClearButton == false else {
            self.didTapClearButton = false
            return self.didTapClearButton
        }
        if !cellVM.isEditable {
            cellVM.cellTappedCallback?()
        }
        return cellVM.isEditable
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let data = self.pickerData,
              let text = textField.text else {
            return
        }
        var componentIndex: Int = .zero
        var rowIndex: Int = .zero
        for (componentIndexTemp, componentArray) in data.enumerated() {
            if let rowIndexTemp = componentArray.firstIndex(of: text) {
                rowIndex = rowIndexTemp
                componentIndex = componentIndexTemp
            }
        }
        self.pickerView.selectRow(
            rowIndex,
            inComponent: componentIndex,
            animated: true
        )
        let currentText = data[componentIndex][rowIndex]
        self.storeEntry(with: currentText)
        textField.text = currentText
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.didTapClearButton = true
        self.storeEntry(with: nil)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cellVM = self.cellVM else {
            return
        }
        guard cellVM.cancelKeyTapped == false else {
            cellVM.cancelKeyTapped = false
            return
        }
        cellVM.returnKeyTapped = true
    }
}

// MARK: - PickerView DataSource

extension TextFieldCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let data = self.pickerData else {
            return .zero
        }
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = self.pickerData else {
            return .zero
        }
        return data[component].count
    }
}

// MARK: - PickerView Delegate

extension TextFieldCell: UIPickerViewDelegate {
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let data = self.pickerData else {
            return nil
        }
        return data[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = self.pickerData else {
            return
        }
        self.textField.text = data[component][row]
        self.storeEntry(with: self.textField.text)
    }
}

extension TextFieldCell: KeyboardDelegate {
    func didTapCancelButton() {
        guard let cellVM = self.cellVM else {
            return
        }
        cellVM.cancelKeyTapped = true
        self.textField.resignFirstResponder()
    }
    
    func didTapDoneButton() {
        self.textField.resignFirstResponder()
    }
}
