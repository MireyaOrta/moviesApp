//
//  TopRated.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import Unbox
import RealmSwift

class TopRated: Object, Unboxable {
    
    //MARK: - Properties
    dynamic var localId: String = NSUUID().uuidString
    var movies = List<Movie>()
    var totalPages: Int?
    
    // MARK: - Enums and Structs
    fileprivate struct JSONKey {
        static let localId = "databaseId"
        static let totalPages = "total_pages"
        static let movies = "results"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        localId = unboxer.unbox(key: JSONKey.localId) ?? NSUUID().uuidString
        totalPages = unboxer.unbox(key: JSONKey.totalPages)
       
        let movies: [Movie]? = unboxer.unbox(key: JSONKey.movies)
        if movies != nil {
            self.movies = List(movies!)
        }
    }
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "localId"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? TopRated else { return false }
        return object.localId == localId
    }
}

