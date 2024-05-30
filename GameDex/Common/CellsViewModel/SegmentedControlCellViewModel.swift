//
//  SegmentedControlCellViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 28/05/2024.
//

import Foundation

final class SegmentedControlCellViewModel: CollectionFormCellViewModel {
    typealias ValueType = String
    
    var cellClass: AnyClass = SegmentedControlCell.self
    var indexPath: IndexPath?
    var cellTappedCallback: (() -> Void)?
    let height: CGFloat = DesignSystem.sizeVerySmall
    
    let segments: [SegmentItemViewModel]
    let selectedSegmentIndex: Int
    var formType: FormType
    var value: ValueType? {
        didSet {
            self.formDelegate?.enableSaveButtonIfNeeded()
            if oldValue != value {
                self.formDelegate?.refreshSectionsDependingOnGameFormat()
            }
        }
    }
    
    weak var formDelegate: FormDelegate?
    
    init(segments: [SegmentItemViewModel],
         formType: FormType,
         value: String? = nil,
         formDelegate: FormDelegate? = nil
    ) {
        self.segments = segments
        self.formType = formType
        self.value = value
        self.formDelegate = formDelegate
        
        guard let value = self.value,
              let index = segments.firstIndex(where: { $0.title == value }) else {
            self.selectedSegmentIndex = .zero
            return
        }
        self.selectedSegmentIndex = index
    }
}
