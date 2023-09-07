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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.label)
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
        self.label.text = cellVM.text
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
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingRegular),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.paddingRegular),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
