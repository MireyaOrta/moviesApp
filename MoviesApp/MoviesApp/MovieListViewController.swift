//
//  MovieListViewController.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listTitleLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: MovieListViewModel
    
    // MARK: Lifecycle
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: MovieListViewController.self), bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getMovies()
    }
    
    // MARK: - Helpers
    func configureNavigationBar() {
        listTitleLabel.text = viewModel.viewTitle
    }
    
    func configureTableView(){
        tableView.registerCell(MoviewPreviewTableViewCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMoviesSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviewCell = tableView.dequeueReusableCell(withIdentifier: MoviewPreviewTableViewCell.reuseIdentifier, for: indexPath)
        
        if let previewCell = moviewCell as? MoviewPreviewTableViewCell {
            let currentMovie = viewModel.movieAt(indexPath.row)
            previewCell.movieTitleLabel.text = currentMovie.title
            if let posterPath = currentMovie.posterPath {
                let urlImage = currentMovie.posterUrl + posterPath
                previewCell.posterImage.loadImage(with: URL(string: urlImage)!, placeholderImage: nil)
            }
        }
        return moviewCell
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.numberOfMoviesSections()  {
            viewModel.getMovies(true)
        }
    }
    
}

// MARK: - MovieListViewModelViewDelegate
extension MovieListViewController: MovieListViewModelViewDelegate {
    func listDidChange(viewModel: MovieListViewModel) {
        tableView.reloadData()
    }
    
    func showAlertError(viewModel: MovieListViewModel, error: ApiError) {
    
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: LocalizableString.ok.localizedString, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
