//
//  SearchViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

protocol SearchViewModelDelegate {
    func updateSearch(with text: String)
}

struct SearchViewModel {
    var isSearchable: Bool
    var isActivated: Bool
    var placeholder: String?    
    var delegate: SearchViewModelDelegate?
}
