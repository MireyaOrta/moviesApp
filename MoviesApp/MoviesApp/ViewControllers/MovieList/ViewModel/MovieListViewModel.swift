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
    
    fileprivate var page = 1
    fileprivate let disposeBag = DisposeBag()
    
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
    
    var topRated: TopRated? {
        didSet{
            movies = topRated?.movies.map { $0 }
        }
    }
    
    var upcoming: Upcoming? {
        didSet{
            movies = upcoming?.movies.map { $0 }
        }
    }
    
    var popular: Popular? {
        didSet{
            movies = popular?.movies.map { $0 }
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
                        let realPopular = self.realm.objects(Popular.self)
                        if (self.popular?.movies.count)! < realPopular.count {
                            self.popular?.movies.append(contentsOf: moviesItems.movies)
                        }
                        try self.realm.commitWrite()
                        self.movies = self.popular?.movies.map { $0 }
                    }catch let error {
                        print(error.localizedDescription)
                    }
                }else{
                    self.popular = moviesItems
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
                        let realTopRated = self.realm.objects(TopRated.self)
                        if (self.topRated?.movies.count)! < realTopRated.count {
                            self.topRated?.movies.append(contentsOf: moviesItems.movies)
                        }
                        try self.realm.commitWrite()
                        self.movies = self.popular?.movies.map { $0 }
                    }catch let error {
                        print(error.localizedDescription)
                    }
                    self.movies = self.topRated?.movies.map { $0 }
                }else{
                    self.topRated = moviesItems
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
                        let realUpcoming = self.realm.objects(Upcoming.self)
                        if (self.upcoming?.movies.count)! < realUpcoming.count {
                            self.upcoming?.movies.append(contentsOf: moviesItems.movies)
                        }
                        try self.realm.commitWrite()
                        self.movies = self.popular?.movies.map { $0 }
                    }catch let error {
                        print(error.localizedDescription)
                    }
                    
                    self.movies = self.upcoming?.movies.map { $0 }
                }else{
                    self.upcoming = moviesItems
                }
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
