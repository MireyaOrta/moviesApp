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
