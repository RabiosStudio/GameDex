//
//  StarRatingCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit
import Cosmos

class StarRatingCell: UICollectionViewCell, CellConfigurable {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor
        label.textAlignment = .left
        label.font = Typography.headline.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starRatingView: CosmosView = {
        let view = CosmosView()
        view.settings.fillMode = .full
        view.settings.starSize = DesignSystem.sizeTiny
        view.settings.starMargin = DesignSystem.paddingSmall
        view.settings.filledColor = UIColor.systemYellow
        view.settings.emptyBorderColor = .secondaryColor
        view.settings.filledBorderColor = UIColor.systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        let clearImage = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.systemGray4, renderingMode: .alwaysOriginal)
        button.setImage(clearImage, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTapClearButton(_:)),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var cellVM: CellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override public func prepareForReuse() {
        self.starRatingView.prepareForReuse()
    }
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? StarRatingCellViewModel else {
            return
        }
        self.cellVM = cellVM
        self.starRatingView.rating = Double(cellVM.value ?? .zero)
        self.setupConstraints()
        self.label.text = cellVM.title
        self.starRatingView.didFinishTouchingCosmos = { rating in
            cellVM.value = Int(self.starRatingView.rating)
        }
    }
    
    @objc private func didTapClearButton(_ sender: UIButton) {
        guard let cellVM = self.cellVM as? StarRatingCellViewModel else {
            return
        }
        self.starRatingView.rating = .zero
        cellVM.value = Int(self.starRatingView.rating)
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.starRatingView)
        self.contentView.addSubview(self.clearButton)
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
            
            self.starRatingView.topAnchor.constraint(
                equalTo: self.label.bottomAnchor,
                constant: DesignSystem.paddingRegular
            ),
            self.starRatingView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingSmall
            ),

            self.starRatingView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            
            self.clearButton.topAnchor.constraint(
                equalTo: self.label.bottomAnchor,
                constant: DesignSystem.paddingRegular
            ),
            self.clearButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            self.clearButton.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingSmall
            ),
            self.clearButton.widthAnchor.constraint(equalTo: self.clearButton.heightAnchor)
        ])
    }
    
}
