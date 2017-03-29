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
import ReachabilitySwift

struct MovieAPI {

   
    private static let reachability = Reachability()!
    
    static func getPopular(page: Int) -> Observable<[Movie]>{
        
        //Internet Conection
       if  reachability.isReachable { 
           return MovieNetworkService.getPopularMovies(page: page)
        }
        return MovieDiskService.getMovies(category: LocalizableString.popular.localizedString)
        
    }
    static func getTopRated(page: Int) -> Observable<[Movie]>{
        if  reachability.isReachable {
            return MovieNetworkService.getTopRatedMovies(page: page)
        }
         return MovieDiskService.getMovies(category: LocalizableString.topRated.localizedString)
    }
    static func getUpcoming(page: Int) -> Observable<[Movie]>{
        if  reachability.isReachable {
            return MovieNetworkService.getUpcomingMovies(page: page)
        }
         return MovieDiskService.getMovies(category: LocalizableString.upcoming.localizedString)
    }
    
    static func searchMovies(s: String?, c: String) -> Observable<[Movie]> {
       return MovieDiskService.searchMovies(search: s, category: c)
    }
}
