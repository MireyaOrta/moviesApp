//
//  MoviesDiskService.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm


struct MoviesDiskService {
    
    // MARK: - Properties
    private static var realm: Realm {
        return try! Realm()
    }
    
    static func getTopRatedMovies() -> [Movie] {
        
        let topRatedResult = realm.objects(Movie.self)
        var topRatedArray: [Movie] = []
        
        for movie in topRatedResult {
            topRatedArray.append(movie)
        }
        
        return topRatedArray
    }
    
}
