//
//  TextViewCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit
import SwiftyTextView

class TextViewCell: UICollectionViewCell, CellConfigurable {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = Typography.headline.font
        label.textColor = .secondaryColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textView: SwiftyTextView = {
        let view = SwiftyTextView()
        view.textAlignment = .left
        view.placeholderColor = UIColor.lightGray
        view.minNumberOfWords = 0
        view.maxNumberOfWords = 50
        view.showTextCountView = true
        view.font = Typography.title2.font
        view.tintColor = .primaryColor
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.secondaryBackgroundColor.cgColor
        view.layer.cornerRadius = DesignSystem.cornerRadiusRegular
        view.isEditable = true
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var cellVM: TextViewCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? TextViewCellViewModel else {
            return
        }
        self.cellVM = cellVM
        self.setupConstraints()
        self.label.text = cellVM.title
    }
    
    func cellPressed(cellViewModel: CellViewModel) {}
    
    private func storeEntry(cellViewModel: CellViewModel?, with text: String) {
        guard let cellVM = self.cellVM else {
            return
        }
        cellVM.title = text
    }
    
    private func setupViews() {
        self.backgroundColor = .primaryBackgroundColor
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.textView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.label.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.label.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.label.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.2
            ),
            
            self.textView.topAnchor.constraint(
                equalTo: self.label.bottomAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.textView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.textView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.textView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingSmall
            )
        ])
    }
}

extension TextViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = self.textView.text else {
            return
        }
        self.storeEntry(cellViewModel: self.cellVM, with: text)
    }
}
