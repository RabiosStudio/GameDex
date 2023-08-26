//
//  ContainerViewController.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol ContainerViewControllerDelegate: AnyObject {
    func configureBottomView(contentViewFactory: ContentViewFactory)
}

class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: CollectionViewModel
    private let layout: UICollectionViewLayout
    
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.layout
    )
    
    private lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.delegate = self
        searchBar.configure()
        return searchBar
    }()
    
    private lazy var stackView: UIStackView = {
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
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        view.backgroundColor = .secondaryBackgroundColor
        return view
    }()
    
    private lazy var bottomView = UIView()
    
    private lazy var stackViewBottomConstraint: NSLayoutConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    
    // MARK: - Init
    
    init(viewModel: CollectionViewModel, layoutBuilder: CollectionLayoutBuilder) {
        self.viewModel = viewModel
        self.layout = layoutBuilder.create()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNotificationObservers()
        self.setupContent()
        self.loadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.navigationController?.updateProgress()
    }
    
    // MARK: - Register
    
    public func registerCells() {
        let sections = self.viewModel.sections
        
        for i in 0..<sections.count {
            let section = sections[i]
            
            // Store section position
            section.position = i
            
            let items = section.cellsVM
            
            for j in 0..<items.count {
                let item = items[j]
                
                // We store index path for item
                item.indexPath = IndexPath(row: j,
                                           section: i)
                
                self.collectionView.register(
                    item.cellClass,
                    forCellWithReuseIdentifier: item.reuseIdentifier
                )
            }
        }
    }
    
    // MARK: - Methods
    
    private func loadData() {
        let tabBarOffset = -(self.tabBarController?.tabBar.frame.size.height ?? 0)
        let emptyLoader = EmptyLoader(tabBarOffset: tabBarOffset)
        self.configureNavBar()
        self.collectionView.updateEmptyScreen(emptyReason: emptyLoader)
        self.collectionView.reloadEmptyDataSet()
        self.viewModel.loadData { [weak self] error in
            
            DispatchQueue.main.async {
                if let error = error {
                    let tabBarOffset = -(self?.tabBarController?.tabBar.frame.size.height ?? 0)
                    self?.updateEmptyState(error: error,
                                           tabBarOffset: tabBarOffset)
                } else {
                    self?.refresh()
                }
            }
        }
    }
    
    private func refresh() {
        self.registerCells()
        self.collectionView.reloadData()
        if self.viewModel.searchViewModel.isActivated {
            self.searchBar.becomeFirstResponder()
        }
    }
    
    private func updateEmptyState(error: EmptyError?, tabBarOffset: CGFloat) {
        if let error = error {
            guard let image = UIImage(named: error.imageName) else {
                return
            }
            let emptyReason = EmptyTextAndButton(
                tabBarOffset: tabBarOffset,
                customTitle: error.errorTitle,
                customDescription: error.errorDescription ?? "",
                image: image,
                buttonTitle: error.buttonTitle
            ) {
                switch error.errorAction {
                case let .navigate(style):
                    _ = Routing.shared.route(navigationStyle: style)
                }
            }
            self.configureNavProgress()
            self.collectionView.updateEmptyScreen(emptyReason: emptyReason)
            self.collectionView.reloadData()
        } else {
            self.registerCells()
            self.configureLayout()
            self.collectionView.reloadData()
        }
    }
    
    private func configureLayout() {
        self.collectionView.collectionViewLayout = self.layout
    }
    
    private func configureNavBar() {
        self.navigationController?.configure()
        self.title = self.viewModel.screenTitle
        self.configureNavProgress()
        
        guard let rightButtonItem = self.viewModel.rightButtonItem else {
            return
        }
        switch rightButtonItem {
        case .close:
            self.navigationItem.rightBarButtonItem = BarButtonItem(image: rightButtonItem.image()
            ) { [weak self] in
                self?.dismiss(animated: true)
            }
        }
    }
    
    private func configureNavProgress() {
        guard let progress = self.viewModel.progress else {
            self.navigationController?.cancelProgress()
            return
        }
        self.navigationController?.primaryColor = .primaryColor
        self.navigationController?.backgroundColor = .secondaryBackgroundColor
        
        // show progress bar
        self.navigationController?.isShowingProgressBar = true
        
        // update progress bar with given value
        self.navigationController?.setProgress(progress, animated: false)
    }
    
    private func addNotificationObservers() {
        // Keyboard animation
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAnimation), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAnimation), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardAnimation(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let animationOption = UIView.AnimationOptions(rawValue: curve.uintValue)
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: animationOption,
            animations: {
                switch notification.name {
                case UIResponder.keyboardWillShowNotification:
                    guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  else { return }
                    self.stackViewBottomConstraint.constant = -keyboardSize.height
                case UIResponder.keyboardWillHideNotification:
                    self.stackViewBottomConstraint.constant = .zero
                default:
                    break
                }
                self.view.layoutIfNeeded()
            }
        )
    }
    
    private func setupContent() {
        self.registerCells()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = self.viewModel.isBounceable
        if self.viewModel.searchViewModel.isSearchable {
            self.stackView.addArrangedSubview(self.searchBar)
            self.searchBar.placeholder = self.viewModel.searchViewModel.placeholder
        }
        self.stackView.addArrangedSubview(self.collectionView)
        self.view.addSubview(stackView)
        self.setupStackViewConstraints()
        self.view.backgroundColor = .primaryBackgroundColor
        self.navigationController?.configure()
    }
    
    private func setupStackViewConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.stackViewBottomConstraint
        ])
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

// MARK: CollectionViewDelegate

extension ContainerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellVM = self.viewModel.item(at: indexPath)
        let configurableCell = cell as? CellConfigurable
        cell.layoutIfNeeded()
        cell.contentView.layer.masksToBounds = true
        configurableCell?.configure(cellViewModel: cellVM)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        guard self.viewModel.itemAvailable(at: indexPath) else {
            return
        }
        let cellVM = self.viewModel.item(at: indexPath)
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellVM.reuseIdentifier,
            for: indexPath)
        let configurableCell = cell as? CellConfigurable
        configurableCell?.cellPressed(cellViewModel: cellVM)
    }
}

// MARK: CollectionViewDataSource

extension ContainerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellVM = self.viewModel.item(at: indexPath)
        let reuseIdentifier = cellVM.reuseIdentifier
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        return cell
    }
}

// MARK: UISearchDelegate

extension ContainerViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // called when text changes (including clear)
        self.viewModel.searchViewModel.delegate?.updateSearch(with: searchText)
        self.collectionView.reloadData()
    }
}

// MARK: ContainerViewControllerDelegate

extension ContainerViewController: ContainerViewControllerDelegate {
    func configureBottomView(contentViewFactory: ContentViewFactory) {
        self.separatorView.removeFromSuperview()
        self.bottomView.removeFromSuperview()
        self.bottomView = contentViewFactory.bottomView
        self.stackView.addArrangedSubview(self.separatorView)
        self.stackView.addArrangedSubview(self.bottomView)
    }
}
