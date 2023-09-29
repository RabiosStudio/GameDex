//
//  ImageCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import UIKit

final class ImageCell: UICollectionViewCell, CellConfigurable {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? ImageCellViewModel else {
            return
        }
        self.imageView.image = UIImage(named: cellVM.imageName)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.paddingLarge),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.paddingLarge),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.paddingLarge),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.paddingLarge)
        ])
    }
    
}
