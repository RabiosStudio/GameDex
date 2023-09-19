//
//  SearchViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

// sourcery: AutoMockable
protocol SearchViewModelDelegate {
    func updateSearchTextField(with text: String, callback: @escaping (EmptyError?) -> ())
    func startSearch(from searchQuery: String, callback: @escaping (EmptyError?) -> ())
}

struct SearchViewModel {
    let placeholder: String
    let activateOnTap: Bool
    var delegate: SearchViewModelDelegate?
}
