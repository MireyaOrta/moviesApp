//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    @IBOutlet weak var popularityTitleLabel: UILabel!
    @IBOutlet weak var popularityCountLabel: UILabel!
    @IBOutlet weak var goToTrailer: UIButton!
    
    
    //MARK: - Properties
    var viewModel: MovieDetailViewModel
    
    // MARK: Lifecycle
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: MovieDetailViewController.self), bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Helpers
    
    fileprivate func configureView(){
        overviewTitleLabel.text = LocalizableString.overviw.localizedString
        popularityTitleLabel.text = LocalizableString.popularity.localizedString
        goToTrailer.titleLabel?.text = LocalizableString.trailer.localizedString
        goToTrailer.backgroundColor = UIColor.lightGray
    }

    @IBAction func openTrailer(_ sender: Any) {
        
    }

}

// MARK: - MovieDetailViewModelViewDelegate
extension MovieDetailViewController: MovieDetailViewModelViewDelegate {
    func movieDidSetUp(viewModel: MovieDetailViewModel) {
        if let movie = viewModel.movie {
            if let posterPath = movie.posterPath {
                let urlImage = movie.posterUrl + posterPath
                movieImageView.loadImage(with: URL(string: urlImage)!, placeholderImage: nil)
            }
            
            movieTitleLabel.text = movie.title
            
            if let overview = movie.overview {
                overviewDetailLabel.text = overview
            }
            
            popularityCountLabel.text = movie.popularity
            
            if let video = movie.video, video {
                goToTrailer.backgroundColor = Color.orange.color
            }
        }
    }
}
