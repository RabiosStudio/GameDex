//
//  ContainerViewController.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

protocol ContainerViewControllerDelegate: AnyObject {
    func configureBottomView(contentViewFactory: ContentViewFactory)
}

class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    private let childVC: UIViewController
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.backgroundColor = .primaryBackgroundColor
        view.layoutMargins = .init(
            top: DesignSystem.paddingRegular,
            left: DesignSystem.paddingRegular,
            bottom: DesignSystem.paddingRegular,
            right: DesignSystem.paddingRegular
        )
        view.isLayoutMarginsRelativeArrangement = true
        view.spacing = DesignSystem.paddingRegular
        return view
    }()
    private let separatorView: UIView = {
        let view = UIView()
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private var bottomView = UIView()
    
    private var keyboardHeight: CGFloat?
    private var keyboardIsVisible: Bool = false
    
    // MARK: - Init
    init(
        childVC: UIViewController
    ) {
        self.childVC = childVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(childVC)
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(childVC.view)
        self.setupStackViewConstraints()
        self.childVC.didMove(toParent: self)
        self.view.backgroundColor = self.childVC.view.backgroundColor
        self.navigationController?.configure()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeight = keyboardSize.height
            guard !self.keyboardIsVisible else {
                return
            }
            self.keyboardIsVisible = true
            animateViewSizeChange(reduced: true)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardHeight = self.keyboardHeight {
            self.keyboardIsVisible = false
            animateViewSizeChange(reduced: false)
        }
    }
    
    private func animateViewSizeChange(reduced: Bool) {
        guard let keyboardHeight = self.keyboardHeight else {
            return
        }
        UIView.animate(withDuration: 0.5, animations: {
            (reduced == true) ? (self.view.frame.size.height -= keyboardHeight) : (self.view.frame.size.height += keyboardHeight)
                self.view.layoutIfNeeded()
            })
    }
    
    private func setupStackViewConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ContainerViewController: ContainerViewControllerDelegate {
    func configureBottomView(contentViewFactory: ContentViewFactory) {
        self.separatorView.removeFromSuperview()
        self.bottomView.removeFromSuperview()
        self.bottomView = contentViewFactory.bottomView
        self.stackView.addArrangedSubview(self.separatorView)
        self.stackView.addArrangedSubview(self.bottomView)
    }
}
