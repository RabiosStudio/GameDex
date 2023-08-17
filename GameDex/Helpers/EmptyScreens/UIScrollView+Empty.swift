//
//  UIScrollView+Empty.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation
import EmptyDataSet_Swift

extension UIScrollView {
    
    func updateEmptyScreen(emptyReason: EmptyReason) {
        self.emptyDataSetView { emptyView in
            emptyView.titleLabelString(emptyReason.attributedTitle)
                .customView(emptyReason.customView)
                .verticalOffset(emptyReason.verticalOffset)
                .detailLabelString(emptyReason.attributedDescription)
                .image(emptyReason.image)
                .buttonTitle(emptyReason.attributedButtonTitle, for: .normal)
                .dataSetBackgroundColor(emptyReason.backgroundColor)
                .didTapDataButton {
                    emptyReason.completionBlock?()
                }
                .detailLabelString(emptyReason.attributedDescription)
                .verticalSpace(emptyReason.verticalSpace)
        }
    }
}
