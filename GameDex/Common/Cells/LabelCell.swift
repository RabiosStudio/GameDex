//
//  LabelCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation
import UIKit

final class LabelCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor
        label.font = Typography.body.font
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "trash")!.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "pencil")!.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var cellVM: LabelCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.stackView)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .secondaryBackgroundColor : .clear
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? LabelCellViewModel else {
            return
        }
        self.cellVM = cellVM
        self.label.text = cellVM.text
        if cellVM.isEditable {
            self.stackView.addArrangedSubview(self.editButton)
        }
        if cellVM.isDeletable {
            self.stackView.addArrangedSubview(self.deleteButton)
        }
        self.setupConstraints()
    }
    
    @objc private func didTapDeleteButton() {
        guard let cellVM = self.cellVM else {
            return
        }
        cellVM.objectManagementDelegate?.delete()
    }
    
    @objc private func didTapEditButton() {
        guard let cellVM = self.cellVM else {
            return
        }
        cellVM.objectManagementDelegate?.edit()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingRegular),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: DesignSystem.paddingRegular),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: DesignSystem.fractionalSizeVerySmall),
            
            self.label.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: DesignSystem.paddingRegular)
        ])
    }
    
}
