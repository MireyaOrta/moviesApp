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
    
    static func getPopularMovies(page: Int) -> Observable<[Movie]> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getPopular(page))
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let movies: [Movie] = try? unbox(dictionary: jsonDictionary, atKey: Key.result) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        MovieDiskService.saveMovies(movies: movies, category: LocalizableString.popular.localizedString)
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
    
    static func getTopRatedMovies(page: Int) -> Observable<[Movie]> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getTopRated(page))
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let movies: [Movie] = try? unbox(dictionary: jsonDictionary, atKey: Key.result) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        MovieDiskService.saveMovies(movies: movies, category: LocalizableString.topRated.localizedString)
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
    
    static func getUpcomingMovies(page: Int) -> Observable<[Movie]> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.getUpcoming(page))
                .validate()
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let jsonData):
                        
                        guard let jsonDictionary = jsonData.toJSONDictionary(), let movies: [Movie] = try? unbox(dictionary: jsonDictionary, atKey: Key.result) else {
                            observer.onError(ApiError.defaultError)
                            break
                        }
                        
                        MovieDiskService.saveMovies(movies: movies, category: LocalizableString.upcoming.localizedString)
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
