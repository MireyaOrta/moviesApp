//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation

protocol HomeViewModelViewDelegate: class {
    func menuDidChange(viewModel: HomeViewModel)
}

protocol HomeViewModelCoordinatorDelegate: class {
    func homeViewModelShowMovieList(viewModel: HomeViewModel, title: String)
}

class HomeViewModel {
    
    var viewDelegate: HomeViewModelViewDelegate?
    var coordinatorDelegate: HomeViewModelCoordinatorDelegate?

    var viewTitle: String? =  LocalizableString.movies.localizedString
   
    var menuSections: [String]? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.viewDelegate?.menuDidChange(viewModel: strongSelf)
            }
        }
    }
    
    func getMenuSections(){
        menuSections = [LocalizableString.search.localizedString, LocalizableString.popular.localizedString, LocalizableString.topRated.localizedString, LocalizableString.upcoming.localizedString]
    }
    
    func numberOfMenuSections() -> Int {
        return menuSections?.count ?? 0
    }
    
    func sectiontitleAt(_ index: Int) -> String {
        return (menuSections?[index])!
    }
    
    func showMoviewResult(_ index: Int) {
        if let section = menuSections?[index] {
            coordinatorDelegate?.homeViewModelShowMovieList(viewModel: self, title: section)
        }
        
    }
}
