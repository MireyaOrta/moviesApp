//
//  HomeCoordinator.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    var rootViewController: UIViewController
    fileprivate var coordinators: [String: Coordinator]
    
    fileprivate var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    // MARK: - Initializers
    init() {
        rootViewController = UINavigationController()
        coordinators = [:]
    }
    
    func start() {
        let homeVM = HomeViewModel()
        homeVM.coordinatorDelegate = self
        let homeVC = HomeViewController(viewModel: homeVM)
        navigationController.tabBarController?.tabBar.isHidden = true
        navigationController.setViewControllers([homeVC], animated: false)
    }
 
    func showMovieList(title: String) {
        let movieListVM = MovieListViewModel()
        movieListVM.viewTitle = title
        movieListVM.coordinatorDelegate = self
        let moviewListVC = MovieListViewController(viewModel: movieListVM)
        navigationController.pushViewController(moviewListVC, animated: true)
    }
    
    func showMovieDetail(_ movie: Movie) {
        let movieDetailVM = MovieDetailViewModel()
        movieDetailVM.movie = movie
        let moviewDetailVC = MovieDetailViewController(viewModel: movieDetailVM)
        navigationController.pushViewController(moviewDetailVC, animated: true)
    }
    
}

// MARK: - HomeViewModelCoordinatorDelegate
extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func homeViewModelShowMovieList(viewModel: HomeViewModel, title: String) {
        showMovieList(title: title)
    }
}

// MARK: - MovieListViewModelCoordinatorDelegate
extension HomeCoordinator: MovieListViewModelCoordinatorDelegate {
    func MovieListViewModelShowMovieDetail(viewModel: MovieListViewModel, movie: Movie) {
        showMovieDetail(movie)
    }
}
