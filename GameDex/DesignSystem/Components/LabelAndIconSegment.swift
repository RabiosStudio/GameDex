//
//  LabelAndIconSegment.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 29/05/2024.
//

import Foundation
import BetterSegmentedControl

class LabelAndIconSegment: BetterSegmentedControlSegment {
    
    // MARK: Constants
    private struct DefaultValues {
        static let normalBackgroundColor: UIColor = .clear
        static let normalTextColor: UIColor = .black
        static let normalFont: UIFont = .systemFont(ofSize: 13)
        static let selectedBackgroundColor: UIColor = .clear
        static let selectedTextColor: UIColor = .black
        static let selectedFont: UIFont = .systemFont(ofSize: 13, weight: .medium)
    }
    
    // MARK: Properties
    public let text: String
    
    public let normalFont: UIFont
    public let normalTextColor: UIColor
    public let normalBackgroundColor: UIColor
    public let selectedFont: UIFont
    public let selectedTextColor: UIColor
    public let selectedBackgroundColor: UIColor
    
    private let numberOfLines: Int
    private let accessibilityIdentifier: String?
    
    public var icon: UIImage?
    public var iconSize: CGSize?
    public var normalIconTintColor: UIColor?
    public var selectedIconTintColor: UIColor?
    
    // MARK: Lifecycle
    public init(text: String,
                numberOfLines: Int = 1,
                normalBackgroundColor: UIColor? = nil,
                normalFont: UIFont? = nil,
                normalTextColor: UIColor? = nil,
                selectedBackgroundColor: UIColor? = nil,
                selectedFont: UIFont? = nil,
                selectedTextColor: UIColor? = nil,
                accessibilityIdentifier: String? = nil,
                icon: UIImage? = nil,
                iconSize: CGSize? = nil,
                normalIconTintColor: UIColor? = nil,
                selectedIconTintColor: UIColor? = nil
    ) {
        self.text = text
        self.numberOfLines = numberOfLines
        self.normalBackgroundColor = normalBackgroundColor ?? DefaultValues.normalBackgroundColor
        self.normalFont = normalFont ?? DefaultValues.normalFont
        self.normalTextColor = normalTextColor ?? DefaultValues.normalTextColor
        self.selectedBackgroundColor = selectedBackgroundColor ?? DefaultValues.selectedBackgroundColor
        self.selectedFont = selectedFont ?? DefaultValues.selectedFont
        self.selectedTextColor = selectedTextColor ?? DefaultValues.selectedTextColor
        self.accessibilityIdentifier = accessibilityIdentifier
        self.icon = icon?.withRenderingMode(.alwaysTemplate)
        self.iconSize = iconSize
        self.normalIconTintColor = normalIconTintColor
        self.selectedIconTintColor = selectedIconTintColor
    }
    
    // MARK: BetterSegmentedControlSegment
    public var intrinsicContentSize: CGSize? {
        selectedView.intrinsicContentSize
    }
    //    public var intrinsicContentSize: CGSize? { nil }
    
    public lazy var normalView: UIView = {
        createView(
            withText: self.text,
            backgroundColor: self.normalBackgroundColor,
            font: self.normalFont,
            textColor: self.normalTextColor,
            withIcon: self.icon,
            iconSize: self.iconSize,
            iconTintColor: self.normalIconTintColor,
            accessibilityIdentifier: self.accessibilityIdentifier
        )
    }()
    
    public lazy var selectedView: UIView = {
        createView(
            withText: self.text,
            backgroundColor: self.selectedBackgroundColor,
            font: self.selectedFont,
            textColor: self.selectedTextColor,
            withIcon: self.icon,
            iconSize: self.iconSize,
            iconTintColor: self.selectedIconTintColor,
            accessibilityIdentifier: self.accessibilityIdentifier
        )
    }()
    
    open func createView(withText text: String,
                         backgroundColor: UIColor,
                         font: UIFont,
                         textColor: UIColor,
                         withIcon icon: UIImage? = nil,
                         iconSize: CGSize? = nil,
                         iconTintColor: UIColor? = nil,
                         accessibilityIdentifier: String?) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.layoutMargins = .init(
            top: DesignSystem.paddingRegular,
            left: DesignSystem.paddingRegular,
            bottom: DesignSystem.paddingRegular,
            right: DesignSystem.paddingRegular
        )
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = numberOfLines
        label.backgroundColor = .clear
        label.font = font
        label.textColor = textColor
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.accessibilityIdentifier = accessibilityIdentifier
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = icon {
            let imageView = UIImageView(image: icon)
//            imageView.frame = CGRect(
//                x: 0,
//                y: 0,
//                width: iconSize?.width ?? DesignSystem.sizeTiny,
//                height: iconSize?.height ?? DesignSystem.sizeTiny
//            )
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = iconTintColor
            imageView.autoresizingMask = [
                .flexibleTopMargin,
                .flexibleLeftMargin,
                .flexibleRightMargin,
                .flexibleBottomMargin
            ]
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.paddingLarge),
                imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: DesignSystem.paddingRegular),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -DesignSystem.paddingRegular),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
                
                label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.paddingLarge)
            ])
        } else {
            view.addSubview(label)
        }
        return view
    }
}

extension LabelAndIconSegment {
    class func segments(with segments: [SegmentItemViewModel],
                        numberOfLines: Int = 1,
                        normalBackgroundColor: UIColor? = nil,
                        normalFont: UIFont? = nil,
                        normalTextColor: UIColor? = nil,
                        selectedBackgroundColor: UIColor? = nil,
                        selectedFont: UIFont? = nil,
                        selectedTextColor: UIColor? = nil,
                        iconSize: CGSize? = nil,
                        normalIconTintColor: UIColor? = nil,
                        selectedIconTintColor: UIColor? = nil
    ) -> [BetterSegmentedControlSegment] {
        var segmentControlSegments = [BetterSegmentedControlSegment]()
        
        for segment in segments {
            segmentControlSegments.append(
                LabelAndIconSegment(
                    text: segment.title,
                    numberOfLines: numberOfLines,
                    normalBackgroundColor: normalBackgroundColor,
                    normalFont: normalFont,
                    normalTextColor: normalTextColor,
                    selectedBackgroundColor: selectedBackgroundColor,
                    selectedFont: selectedFont,
                    selectedTextColor: selectedTextColor,
                    accessibilityIdentifier: nil,
                    icon: segment.image,
                    iconSize: iconSize,
                    normalIconTintColor: normalIconTintColor,
                    selectedIconTintColor: selectedIconTintColor
                )
            )
        }
        
        return segmentControlSegments
    }
}
