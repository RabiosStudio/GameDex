//
//  EnterGameDetailsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

struct EnterGameDetailsScreenFactory: ScreenFactory {
    
    var section1LayoutBuilder: BasicGroupLayoutBuilder
    var section2LayoutBuilder: BasicGroupLayoutBuilder
    var section3LayoutBuilder: BasicGroupLayoutBuilder
    
    var viewController: UIViewController {
        let viewModel = EnterGameDetailsViewModel(game: self.game)
        
        let sectionsBuilder: [BasicGroupLayoutBuilder] = [
            section1LayoutBuilder,
            section2LayoutBuilder,
            section3LayoutBuilder
        ]
        
        let layoutBuilder = TestLayoutBuilder(sectionsBuilder: sectionsBuilder)
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layoutBuilder: layoutBuilder
        )
        return containerController
    }
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
        self.section1LayoutBuilder = BasicGroupLayoutBuilder(
            cellLayout:
                CellLayout(
                    size: .veryBig,
                    horizontalSpacing: .small,
                    verticalSpacing: .none
                )
        )
        self.section2LayoutBuilder = BasicGroupLayoutBuilder(
            cellLayout:
                CellLayout(
                    size: .small,
                    horizontalSpacing: .small,
                    verticalSpacing: .small
                )
        )
        self.section3LayoutBuilder = BasicGroupLayoutBuilder(
            cellLayout:
                CellLayout(
                    size: .regular,
                    horizontalSpacing: .small,
                    verticalSpacing: .small
                )
        )
    }
}
