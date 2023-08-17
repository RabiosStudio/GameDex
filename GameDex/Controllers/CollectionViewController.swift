//
//  CollectionViewController.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/08/2023.
//

import UIKit
import EmptyDataSet_Swift

class CollectionViewController: UICollectionViewController {
    
    // MARK: Properties

    private let viewModel: CollectionViewModel
    private let layout: UICollectionViewLayout
    
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
        self.collectionView.backgroundColor = .systemBackground
        self.registerCells()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBarOffset = -(self.tabBarController?.tabBar.frame.size.height ?? 0)
        let emptyLoader = EmptyLoader(tabBarOffset: tabBarOffset)
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
    
    private func updateEmptyState(error: EmptyError, tabBarOffset: CGFloat) {
        
        let emptyReason = EmptyTextAndButton(tabBarOffset: tabBarOffset,
                                             customTitle: error.errorTitle,
                                             customDescription: error.errorDescription ?? "",
                                             image: UIImage(named: error.imageName)!,
                                             buttonTitle: error.buttonTitle) {
            switch error.errorAction {
            case .refresh:
                print("refresh")
            case .search:
                print("search")
            case .navigate:
                print("navigate")
            }
        }
        collectionView.updateEmptyScreen(emptyReason: emptyReason)
        collectionView.reloadData()
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
