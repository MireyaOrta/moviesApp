//
//  MovieAPI.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct MovieAPI {
    
    static func getPopular(page: Int) -> Observable<[Movie]>{
        return MovieNetworkService.getPopularMovies(page: page)
    }
}
