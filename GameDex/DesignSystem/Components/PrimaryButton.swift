//
//  PrimaryButton.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit
import NVActivityIndicatorView

// sourcery: AutoMockable
protocol PrimaryButtonDelegate: AnyObject {
    func didTapPrimaryButton()
}

final class PrimaryButton: UIButton {
    
    private lazy var loader: UIView = {
        let view = NVActivityIndicatorView(
            frame: CGRect(
                x: .zero,
                y: .zero,
                width: self.frame.width,
                height: self.frame.height
            ),
            type: .ballRotateChase,
            color: .white,
            padding: DesignSystem.paddingSmall
        )
        view.startAnimating()
        view.centerInSuperview()
        return view
    }()
    
    weak var delegate: PrimaryButtonDelegate?
    
    init(delegate: PrimaryButtonDelegate?, shouldEnable: Bool) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.addTarget(
            self,
            action: #selector(didTapPrimaryButton(_:)),
            for: .touchUpInside
        )
        self.isEnabled = shouldEnable
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(viewModel: ButtonViewModel) {
        self.layer.cornerRadius = DesignSystem.cornerRadiusBig
        self.titleLabel?.font = Typography.calloutBold.font
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = DesignSystem.numberOfLinesStandard
        self.setTitleColor(.primaryBackgroundColor, for: .normal)
        self.updateButtonDesignForState(buttonTitle: viewModel.title)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let height: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? DesignSystem.buttonHeightRegular : DesignSystem.buttonHeightBig
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
    
    private func setupLoaderConstraints() {
        NSLayoutConstraint.activate(
            [
                self.loader.topAnchor.constraint(equalTo: self.topAnchor),
                self.loader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.loader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.loader.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        )
    }
    
    @objc private func didTapPrimaryButton(_ sender: PrimaryButton) {
        self.isEnabled = false
        self.updateButtonDesignForState(buttonTitle: nil)
        self.delegate?.didTapPrimaryButton()
    }
    
    private func showLoader() {
        self.addSubview(self.loader)
        self.setupLoaderConstraints()
        
    }
    
    func updateButtonDesignForState(buttonTitle: String?) {
        self.setTitle(buttonTitle, for: .normal)
        if self.isEnabled {
            self.backgroundColor = .secondaryColor
        } else {
            self.showLoader()
            self.backgroundColor = .systemGray3
        }
    }
}
