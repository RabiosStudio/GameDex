//
//  LabelCollectionViewCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import Foundation
import UIKit

final class LabelCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Typography.body.font
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .primaryBackgroundColor
        contentView.addSubview(self.label)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? LabelCellViewModel else {
            return
        }
        self.label.text = cellVM.text
        setupConstraints()
    }
}
