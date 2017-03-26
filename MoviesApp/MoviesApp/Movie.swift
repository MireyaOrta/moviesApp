//
//  Movies.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit
import Unbox
import RealmSwift

class Movie: Object, Unboxable {
    
    //MARK: - Properties
    dynamic var localId: String = NSUUID().uuidString
    var movieId: Int?
    var title: String?
    var popularity: String?
    var overview: String?
    var video: Bool?
    var homepage: String?
    var posterUrl: String = "https://image.tmdb.org/t/p/w342/"
    var posterPath: String?     
    
    // MARK: - Enums and Structs
    fileprivate struct JSONKey {
        static let movieId = "id"
        static let title = "title"
        static let popularity = "popularity"
        static let overview = "overview"
        static let video = "video"
        static let homepage = "homePage"
        static let posterPath = "poster_path"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        movieId = unboxer.unbox(key: JSONKey.movieId)
        title = unboxer.unbox(key: JSONKey.title)
        popularity = unboxer.unbox(key: JSONKey.popularity)
        overview = unboxer.unbox(key: JSONKey.overview)
        video = unboxer.unbox(key: JSONKey.video)
        homepage = unboxer.unbox(key: JSONKey.homepage)
        posterPath = unboxer.unbox(key: JSONKey.posterPath)
    }
    
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "localId"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Movie else { return false }
        return object.localId == localId
    }
}
