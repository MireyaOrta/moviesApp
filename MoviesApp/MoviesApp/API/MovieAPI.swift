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
    
    static func getPopular(page: Int) -> Observable<Popular>{
        
        //Internet Conection
       if  reachability.isReachable { 
           return MovieNetworkService.getPopularMovies(page: page)
        }
        return MovieDiskService.getPopularMovies()
        
    }
    static func getTopRated(page: Int) -> Observable<TopRated>{
        if  reachability.isReachable {
            return MovieNetworkService.getTopRatedMovies(page: page)
        }
        return MovieDiskService.getTopRatedMovies()
    }
    static func getUpcoming(page: Int) -> Observable<Upcoming>{
        if  reachability.isReachable {
            return MovieNetworkService.getUpcomingMovies(page: page)
        }
        return MovieDiskService.getUpcomingMovies()
    }
}
