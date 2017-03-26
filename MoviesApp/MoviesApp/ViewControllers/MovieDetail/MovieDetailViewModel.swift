//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelViewDelegate: class {
   func movieDidSetUp(viewModel: MovieDetailViewModel)
}

protocol MovieDetailViewModelCoordinatorDelegate: class {
    
}

class MovieDetailViewModel {
    
    var viewDelegate: MovieDetailViewModelViewDelegate?
    var coordinatorDelegate: MovieDetailViewModelCoordinatorDelegate?
    
    var movie: Movie? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.viewDelegate?.movieDidSetUp(viewModel: strongSelf)
            }
        }
    }
    
}
