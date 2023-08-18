//
//  CollectionViewController.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/08/2023.
//

import UIKit
import EmptyDataSet_Swift

class CollectionViewController: UICollectionViewController, AnyChildVC {
    
    // MARK: Properties

    private let viewModel: CollectionViewModel
    private let layout: UICollectionViewLayout
    var navigationDelegate: NavigationDelegate?
    
    // MARK: Init
    
    init(viewModel: CollectionViewModel, layoutBuilder: CollectionLayoutBuilder) {
        self.viewModel = viewModel
        self.layout = layoutBuilder.create()
        super.init(collectionViewLayout: self.layout)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .primaryBackgroundColor
        self.registerCells()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBarOffset = -(self.tabBarController?.tabBar.frame.size.height ?? 0)
        let emptyLoader = EmptyLoader(tabBarOffset: tabBarOffset)
        self.configureNavBar()
        collectionView.updateEmptyScreen(emptyReason: emptyLoader)
        self.viewModel.loadData { [weak self] error in
            if let error = error {
                let tabBarOffset = -(self?.tabBarController?.tabBar.frame.size.height ?? 0)
                self?.updateEmptyState(error: error,
                                       tabBarOffset: tabBarOffset)
            }
        }
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
    
    // MARK: Methods
    
    private func updateEmptyState(error: EmptyError?, tabBarOffset: CGFloat) {
        if let error = error {
            let emptyReason = EmptyTextAndButton(
                tabBarOffset: tabBarOffset,
                customTitle: error.errorTitle,
                customDescription: error.errorDescription ?? "",
                image: UIImage(named: error.imageName)!,
                buttonTitle: error.buttonTitle
            ) {
                switch error.errorAction {                
                case let .navigate(style):
                    _ = Routing.shared.route(navigationStyle: style)
                }
            }
            collectionView.updateEmptyScreen(emptyReason: emptyReason)
            collectionView.reloadData()
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
        self.navigationItem.title = self.viewModel.screenTitle
        
        self.navigationDelegate?.sendNavigationTitle(title: self.navigationItem.title)
        
        guard let rightButtonItem = self.viewModel.rightButtonItem else {
            return
        }
        
        switch rightButtonItem {
        case .close:
            self.navigationItem.rightBarButtonItem = BarButtonItem(image: rightButtonItem.image()
            ) { [weak self] in
                self?.dismiss(animated: true)
            }
            guard let navigationItem = self.navigationItem.rightBarButtonItem else {
                return
            }
            self.navigationDelegate?.sendBarButtonItem(item: navigationItem)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(in: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellVM = self.viewModel.item(at: indexPath)
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellVM.reuseIdentifier,
            for: indexPath
        )
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellVM = self.viewModel.item(at: indexPath)
        let configurableCell = cell as? CellConfigurable
        cell.layoutIfNeeded()
        configurableCell?.configure(cellViewModel: cellVM)
    }
}
