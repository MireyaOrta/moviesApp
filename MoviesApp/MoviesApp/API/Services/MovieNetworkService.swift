//
//  MovieNetworkService.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Unbox

struct MovieNetworkService {
    
    struct Key {
        static let result = "results"
    }
    
    static func getPopularMovies(page: Int) -> Observable<Popular> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getPopular(page))
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let movies: Popular = try? unbox(dictionary: jsonDictionary) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        MovieDiskService.savePopularMovies(movies: movies)
                        observer.onNext(movies)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        let apiError = ApiError(error: error, data:  response.data) ?? .defaultError
                        observer.onError(apiError)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    static func getTopRatedMovies(page: Int) -> Observable<TopRated> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getTopRated(page))
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let movies: TopRated = try? unbox(dictionary: jsonDictionary) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        MovieDiskService.saveTopRatedMovies(movies: movies)
                        observer.onNext(movies)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        let apiError = ApiError(error: error, data:  response.data) ?? .defaultError
                        observer.onError(apiError)
                    }
            }
            
            return Disposables.create()
        }
    }
    
    static func getUpcomingMovies(page: Int) -> Observable<Upcoming> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getUpcoming(page))
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let movies: Upcoming = try? unbox(dictionary: jsonDictionary) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        MovieDiskService.saveUpcomingMovies(movies: movies)
                        observer.onNext(movies)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        let apiError = ApiError(error: error, data:  response.data) ?? .defaultError
                        observer.onError(apiError)
                    }
            }
            
            return Disposables.create()
        }
    }
}
