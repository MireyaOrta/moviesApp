//
//  MovieDiskService.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm


struct MovieDiskService {
    
    // MARK: - Properties
    private static var realm: Realm {
        return try! Realm()
    }
    
     // MARK: - Save Data
    static func saveMovies(movies: [Movie],category: String) {
           do {
                realm.beginWrite()
            for m in movies {
                switch category {
                case LocalizableString.popular.localizedString:
                    m.popular = true
                case LocalizableString.topRated.localizedString:
                    m.topRated = true
                default:
                    m.upcoming = true
                }
            }
            realm.add(movies, update: true)
                try realm.commitWrite()
           }catch let error {
            print(error.localizedDescription)
            }
        }
    

     // MARK: - Get Data
    static func getMovies(category: String) -> Observable<[Movie]> {
        return Observable.create { (observer) -> Disposable in
            
            let predicate: NSPredicate?
            
            switch category {
            case LocalizableString.popular.localizedString:
                predicate = NSPredicate(format: "popular == true")
            case LocalizableString.topRated.localizedString:
                predicate = NSPredicate(format: "topRated == true")
        
            default:
                predicate = NSPredicate(format: "upcoming == true")
            }
            
             let MoviesData = realm.objects(Movie.self).filter(predicate!).toArray()
                observer.onNext(MoviesData)
                observer.onCompleted()
     
            return Disposables.create()
        }
    }
    
    static func searchMovies(search: String?, category: String) -> Observable<[Movie]> {
        return Observable.create { (observer) -> Disposable in
            let predicate: NSPredicate?
            
            switch category {
            case LocalizableString.popular.localizedString:
                predicate = NSPredicate(format: "popular == true AND title CONTAINS %@", search!)
            case LocalizableString.topRated.localizedString:
                predicate = NSPredicate(format: "topRated == true AND title CONTAINS %@", search!)
            case LocalizableString.upcoming.localizedString:
                predicate = NSPredicate(format: "upcoming == true AND title CONTAINS %@", search!)
            default:
                predicate = nil
            }
            
            let pMovies: [Movie]
            if let predicate = predicate {
                pMovies = realm.objects(Movie.self).filter(predicate).toArray()
            } else {
                pMovies = realm.objects(Movie.self).toArray()
            }
            
            observer.onNext(pMovies)
            observer.onCompleted()
        
            return Disposables.create()
        }
    }
}
