//
//  LabelCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation
import UIKit

final class LabelCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var primaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor
        label.font = Typography.body.font
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor
        label.font = Typography.body.font
        label.textAlignment = .right
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.primaryLabel)
        self.contentView.addSubview(self.secondaryLabel)
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
        self.primaryLabel.text = nil
        self.secondaryLabel.text = nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? LabelCellViewModel else {
            return
        }
        self.primaryLabel.text = cellVM.primaryText
        self.secondaryLabel.text = cellVM.secondaryText
        self.setupConstraints()
    }
    
    func cellPressed(cellViewModel: CellViewModel) {
        guard let navigationStyle = cellViewModel.navigationStyle else {
            return
        }
        _ =  Routing.shared.route(navigationStyle: navigationStyle)        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.primaryLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.primaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingRegular),
            self.primaryLabel.trailingAnchor.constraint(equalTo: self.secondaryLabel.leadingAnchor),
            self.primaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.secondaryLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.secondaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.paddingRegular),
            self.secondaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
