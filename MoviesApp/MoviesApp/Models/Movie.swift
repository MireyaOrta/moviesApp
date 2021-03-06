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
  
    dynamic var title: String? = nil
    dynamic var popularity: String? = nil
    dynamic var overview: String? = nil
   
    let video = RealmOptional<Bool>()
    dynamic var posterUrl: String = "https://image.tmdb.org/t/p/w342/"
    dynamic var posterPath: String? = nil
    dynamic var popular = false
    dynamic var topRated = false
    dynamic var upcoming = false
    
    // MARK: - Enums and Structs
    fileprivate struct JSONKey {
        static let localId = "databaseId"
        static let movieId = "id"
        static let title = "title"
        static let popularity = "popularity"
        static let overview = "overview"
        static let video = "video"
        static let posterPath = "poster_path"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        title = unboxer.unbox(key: JSONKey.title)
        popularity = unboxer.unbox(key: JSONKey.popularity)
        overview = unboxer.unbox(key: JSONKey.overview)
        posterPath = unboxer.unbox(key: JSONKey.posterPath)
        do {
        localId = try unboxer.unbox(key: JSONKey.movieId)
        }catch let error{
            print(error)
        }
        var video: Int? = unboxer.unbox(key: JSONKey.video)
        if let videoUnr = video {
            video = videoUnr
        }
        
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
