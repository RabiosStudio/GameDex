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
    func didTapPrimaryButton(with title: String?) async
}

final class PrimaryButton: UIButton {
    
    private lazy var loader: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(
            frame: CGRect(
                x: .zero,
                y: .zero,
                width: DesignSystem.sizeVerySmall,
                height: DesignSystem.sizeVerySmall
            ),
            type: .ballRotateChase,
            color: .white,
            padding: DesignSystem.paddingSmall
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: PrimaryButtonDelegate?
    
    init(delegate: PrimaryButtonDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.addTarget(
            self,
            action: #selector(didTapPrimaryButton(_:)),
            for: .touchUpInside
        )
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
        let state: ButtonState = viewModel.isEnabled ? .enabled(viewModel.buttonTitle) : .disabled(viewModel.buttonTitle)
        self.updateButtonDesign(state: state)
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
                self.loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ]
        )
    }
    
    @objc private func didTapPrimaryButton(_ sender: PrimaryButton) {
        self.updateButtonDesign(state: .loading)
        Task {
            await self.delegate?.didTapPrimaryButton(with: self.titleLabel?.text)
        }
    }
    
    private func showLoader() {
        self.addSubview(self.loader)
        self.setupLoaderConstraints()
        self.loader.startAnimating()
    }
    
    private func hideLoader() {
        self.loader.removeFromSuperview()
    }
    
    func updateButtonDesign(state: ButtonState) {
        switch state {
        case .loading:
            self.isEnabled = false
            self.showLoader()
            self.setTitle(nil, for: [])
            self.backgroundColor = .systemGray3
        case let .enabled(title):
            self.isEnabled = true
            self.setTitle(title, for: .normal)
            self.backgroundColor = .secondaryColor
            self.hideLoader()
        case let .disabled(title):
            self.isEnabled = false
            self.setTitle(title, for: .disabled)
            self.backgroundColor = .systemGray3
            self.hideLoader()
        }
    }
}
