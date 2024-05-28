//
//  SegmentedControlCell.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/05/2024.
//

import Foundation
import UIKit
import BetterSegmentedControl

class SegmentedControlCell: UICollectionViewCell, CellConfigurable {
    
    private enum Constants {
        static let segmentedControlAnimation: CGFloat = 1.0
    }
    
    private let segmentedControl: BetterSegmentedControl = {
        let control = BetterSegmentedControl()
        control.setOptions([
            .backgroundColor(.secondaryBackgroundColor),
            .indicatorViewBackgroundColor(.secondaryColor),
            .cornerRadius(DesignSystem.cornerRadiusBig),
            .animationSpringDamping(Constants.segmentedControlAnimation)
        ])
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
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
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellVM = cellViewModel as? SegmentedControlCellViewModel else {
            return
        }
        self.cellVM = cellVM
        self.setupConstraints()
        self.segmentedControl.segments = LabelSegment.segments(
            withTitles: cellVM.segments,
            normalTextColor: .secondaryColor,
            selectedTextColor: .primaryBackgroundColor
        )
        self.segmentedControl.setIndex(cellVM.selectedSegmentIndex)
    }
    
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        guard let cellVM = self.cellVM as? SegmentedControlCellViewModel else {
            return
        }
        let index = sender.index
        cellVM.value = cellVM.segments[index]
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.segmentedControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.segmentedControl.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: DesignSystem.paddingSmall
            ),
            self.segmentedControl.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: DesignSystem.paddingLarge
            ),
            self.segmentedControl.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -DesignSystem.paddingLarge
            ),
            self.segmentedControl.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -DesignSystem.paddingRegular
            )
        ])
    }
}
