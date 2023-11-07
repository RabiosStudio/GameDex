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
    func configureSupplementaryView(contentViewFactory: ContentViewFactory)
    func reloadSections()
    func goBackToRootViewController()
    func reloadNavBar()
}

class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: CollectionViewModel
    private let layout: UICollectionViewLayout
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.layout
    )
    
    private lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.configure()
        return searchBar
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
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
    
    private lazy var supplementaryView = UIView()
    
    private lazy var stackViewBottomConstraint: NSLayoutConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    
    // MARK: - Init
    
    init(viewModel: CollectionViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        self.layout = layout
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavProgress()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.navigationController?.updateProgress()
    }
    
    // MARK: - Register
    
    private func registerCells() {
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
    
    @objc private func loadData() {
        self.configureLoader()
        Task {
            await self.viewModel.loadData { [weak self] error in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    if let error = error {
                        let tabBarOffset = -(self?.tabBarController?.tabBar.frame.size.height ?? 0)
                        strongSelf.updateEmptyState(
                            error: error,
                            tabBarOffset: tabBarOffset
                        )
                    } else {
                        strongSelf.refresh()
                    }
                    strongSelf.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func refresh() {
        self.configureNavBar()
        self.registerCells()
        self.collectionView.reloadData()
    }
    
    private func updateEmptyState(error: EmptyError?, tabBarOffset: CGFloat) {
        DispatchQueue.main.async {
            self.configureNavBar()
            if let error = error {
                guard let imageName = error.imageName,
                      let image = UIImage(named: imageName) else {
                    return
                }
                let emptyReason = EmptyTextAndButton(
                    tabBarOffset: tabBarOffset,
                    customTitle: error.errorTitle,
                    descriptionText: error.errorDescription,
                    image: image,
                    buttonTitle: error.buttonTitle
                ) {
                    switch error.errorAction {
                    case let .navigate(style):
                        _ = Routing.shared.route(navigationStyle: style)
                    case .refresh:
                        self.refresh()
                    case .none:
                        break
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
    }
    
    private func configureLayout() {
        self.collectionView.collectionViewLayout = self.layout
    }
    
    private func configureNavBar() {
        DispatchQueue.main.async {
            self.navigationController?.configure()
            self.configureSearchBar()
            
            guard let rightButtonItem = self.viewModel.rightButtonItems else {
                return
            }
            
            var buttonItemsConfigured = [BarButtonItem]()
            for item in rightButtonItem {
                switch item {
                case .search:
                    buttonItemsConfigured.append(
                        BarButtonItem(
                            image: item.image(), actionHandler: { [weak self] in
                                self?.handleShowSearchBarOnTap()
                            }
                        )
                    )
                default:
                    buttonItemsConfigured.append(
                        BarButtonItem(
                            image: item.image(), actionHandler: { [weak self] in
                                self?.viewModel.didTapRightButtonItem()
                            }
                        )
                    )
                }
            }
            
            switch rightButtonItem {
            default:
                self.navigationItem.rightBarButtonItems = buttonItemsConfigured
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
    
    private func configureSearchBar() {
        guard let searchVM = self.viewModel.searchViewModel,
              searchVM.activateOnTap == false else {
            self.title = self.viewModel.screenTitle
            return
        }
        DispatchQueue.main.async {
            self.searchBar.becomeFirstResponder()
        }
        self.searchBar.placeholder = searchVM.placeholder
        self.navigationItem.titleView = self.searchBar
    }
    
    private func handleShowSearchBarOnTap() {
        guard let searchVM = self.viewModel.searchViewModel else { return }
        self.searchBar.placeholder = searchVM.placeholder
        self.searchBar.showsCancelButton = true
        self.searchBar.becomeFirstResponder()
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.titleView = self.searchBar
    }
    
    private func configureLoader() {
        let tabBarOffset = -(self.tabBarController?.tabBar.frame.size.height ?? 0)
        let emptyLoader = EmptyLoader(tabBarOffset: tabBarOffset)
        self.collectionView.updateEmptyScreen(emptyReason: emptyLoader)
        self.collectionView.reloadEmptyDataSet()
    }
    
    private func addNotificationObservers() {
        // Keyboard animation
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAnimation), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardAnimation), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Call loadData when app enters foreground
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: UIApplication.willEnterForegroundNotification, object: nil)
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
                self.view.layoutIfNeeded()
            }
        )
    }
    
    private func setupContent() {
        self.registerCells()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceVertical = self.viewModel.isBounceable
        self.collectionView.addSubview(self.refreshControl)
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
        guard self.viewModel.itemAvailable(at: indexPath) else {
            return
        }
        let cellVM = self.viewModel.item(at: indexPath)
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellVM.reuseIdentifier,
            for: indexPath
        )
        
        let configurableCell = cell as? CellConfigurable
        configurableCell?.cellTapped(cellViewModel: cellVM)
        collectionView.deselectItem(at: indexPath, animated: true)
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

// MARK: UISearchTextFieldDelegate
extension ContainerViewController: UISearchTextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.viewModel.searchViewModel?.delegate?.updateSearchTextField(with: "", callback: { [weak self] error in
            if let error = error {
                let tabBarOffset = -(self?.tabBarController?.tabBar.frame.size.height ?? 0)
                self?.updateEmptyState(error: error,
                                       tabBarOffset: tabBarOffset)
            } else {
                self?.refresh()
            }
        })
        return true
    }
}

// MARK: UISearchDelegate
extension ContainerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.navigationItem.titleView = nil
        self.viewModel.searchViewModel?.delegate?.cancelButtonTapped(callback: { [weak self] error in
            if let error = error {
                let tabBarOffset = -(self?.tabBarController?.tabBar.frame.size.height ?? 0)
                self?.updateEmptyState(error: error,
                                       tabBarOffset: tabBarOffset)
            } else {
                self?.refresh()
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else {
            return
        }
        self.searchBar.endEditing(true)
        self.configureLoader()
        self.viewModel.searchViewModel?.delegate?.startSearch(
            from: searchQuery) { [weak self] error in
                if let error = error {
                    DispatchQueue.main.async {
                        let tabBarOffset = -(self?.tabBarController?.tabBar.frame.size.height ?? 0)
                        self?.updateEmptyState(error: error,
                                               tabBarOffset: tabBarOffset)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.refresh()
                    }
                }
            }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // called when text changes (including clear)
        self.viewModel.searchViewModel?.delegate?.updateSearchTextField(with: searchText) { [weak self] error in
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

// MARK: ContainerViewControllerDelegate
extension ContainerViewController: ContainerViewControllerDelegate {
    func goBackToRootViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func configureSupplementaryView(contentViewFactory: ContentViewFactory) {
        DispatchQueue.main.async {
            self.separatorView.removeFromSuperview()
            self.supplementaryView.removeFromSuperview()
            self.supplementaryView = contentViewFactory.contentView
            self.stackView.addArrangedSubview(self.separatorView)
            if contentViewFactory.position == .top {
                self.stackView.insertArrangedSubview(self.supplementaryView, at: 0)
            } else {
                self.stackView.addArrangedSubview(self.supplementaryView)
            }
        }
    }
    
    func reloadSections() {
        DispatchQueue.main.async {
            self.supplementaryView.removeFromSuperview()
            self.loadData()
        }
    }
    
    func reloadNavBar() {
        self.configureNavBar()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ContainerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellVM = self.viewModel.item(at: indexPath)
        let collectionCellVM = cellVM as? CollectionCellViewModel
        return CGSize(
            width: collectionView.frame.size.width - DesignSystem.paddingRegular,
            height: collectionCellVM?.height ?? DesignSystem.sizeRegular
        )
    }
}
