//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol MovieListViewModelViewDelegate: class {
    func listDidChange(viewModel: MovieListViewModel)
    func showAlertError(viewModel: MovieListViewModel, error: ApiError)
}

protocol MovieListViewModelCoordinatorDelegate: class {
    func MovieListViewModelShowMovieDetail(viewModel: MovieListViewModel, movie: Movie)
}

class MovieListViewModel {
    
    var viewDelegate: MovieListViewModelViewDelegate?
    var coordinatorDelegate: MovieListViewModelCoordinatorDelegate?
    
    var viewTitle: String!
    
    
    fileprivate let disposeBag = DisposeBag()
    
    var page = 1
    var noSearch: Bool = true
    
    private var realm: Realm {
        return try! Realm()
    }
    
    var movies: [Movie]? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.viewDelegate?.listDidChange(viewModel: strongSelf)
            }
        }
    }

    func getMovies(_ more: Bool = false) {
        if more {
            page += 1
        }
        switch viewTitle {
        case LocalizableString.popular.localizedString:
            getPopularMovies()
        case LocalizableString.topRated.localizedString:
            getTopRatedMovies()
        case LocalizableString.upcoming.localizedString:
            getTopRatedMovies()
        default:
            break
        }
        
    }
    
    func getPopularMovies() {
        MovieAPI.getPopular(page: self.page)
            .do(onNext: { (moviesItems) in
                if self.page > 1 {
                    do {
                        self.realm.beginWrite()
                        let realPopular = self.realm.objects(Movie.self).filter("popular == true")
                        if (self.movies?.count)! < realPopular.count && self.noSearch {
                            self.movies?.append(contentsOf: moviesItems)
                        }
                        try self.realm.commitWrite()
                    }catch let error {
                        print(error.localizedDescription)
                    }
                }else{
                    self.movies = moviesItems
                }
            }, onError: { (error) in
                let error = error as? ApiError ?? ApiError.defaultError
                self.viewDelegate?.showAlertError(viewModel: self, error: error)
            })
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    func getTopRatedMovies() {
        MovieAPI.getTopRated(page: self.page)
            .do(onNext: { (moviesItems) in
                if self.page > 1 {
                    do {
                        self.realm.beginWrite()
                        let realTopRated = self.realm.objects(Movie.self).filter("topRated == true")
                        if (self.movies?.count)! < realTopRated.count && self.noSearch {
                            self.movies?.append(contentsOf: moviesItems)
                        }
                        try self.realm.commitWrite()
                
                    }catch let error {
                        print(error.localizedDescription)
                    }
                    
                }else{
                    self.movies = moviesItems
                }
            }, onError: { (error) in
                let error = error as? ApiError ?? ApiError.defaultError
                self.viewDelegate?.showAlertError(viewModel: self, error: error)
            })
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    func getUpcomingMovies() {
        MovieAPI.getUpcoming(page: self.page)
            .do(onNext: { (moviesItems) in
                if self.page > 1 {
                    do {
                        self.realm.beginWrite()
                        let realTopRated = self.realm.objects(Movie.self).filter("upcoming == true")
                        if (self.movies?.count)! < realTopRated.count && self.noSearch {
                            self.movies?.append(contentsOf: moviesItems)
                        }
                        try self.realm.commitWrite()
                    
                    }catch let error {
                        print(error.localizedDescription)
                    }
                    
                 
                }else{
                    self.movies = moviesItems
                }
            }, onError: { (error) in
                let error = error as? ApiError ?? ApiError.defaultError
                self.viewDelegate?.showAlertError(viewModel: self, error: error)
            })
            .subscribe()
            .addDisposableTo(disposeBag)
    }
    
    func searchPopularMovies(search: String) {
        noSearch = false
        MovieAPI.searchMovies(s: search, c: viewTitle)
            .do(onNext: { (moviesItems) in
                    self.movies = moviesItems
            }, onError: { (error) in
                let error = error as? ApiError ?? ApiError.defaultError
                self.viewDelegate?.showAlertError(viewModel: self, error: error)
            })
            .subscribe()
            .addDisposableTo(disposeBag)

    }
    
    func numberOfMoviesSections() -> Int {
        return movies?.count ?? 0
    }
    
    func movieAt(_ index: Int) -> Movie {
        return (movies?[index])!
    }
    
    func showMovieDetail(_ index: Int) {
        coordinatorDelegate?.MovieListViewModelShowMovieDetail(viewModel: self, movie: movies![index])
    }
    
}
