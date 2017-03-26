//
//  Router.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: AnyObject]

enum Router {
    
    // MARK: - Configuration

    static let baseHostPath = "https://api.themoviedb.org"
    static let versionPath = "/3"
    static let movie = "/movie"
    
    static let apiKey = "e676000cc6f72318b6cf296eb08e5dfd"
    var baseURLPath: String {
        return "\(Router.baseHostPath)\(Router.versionPath)\(Router.movie)"
    }
    
    // Movies
    case getPopular(Int)
    case getTopRated(Int)
    case getUpcoming(Int)
    
}

extension Router {
    
    struct Request {
        let method: Alamofire.HTTPMethod
        let path: String
        let encoding: ParameterEncoding?
        let parameters: JSONDictionary?
        
        init(method: Alamofire.HTTPMethod,
             path: String,
             parameters: JSONDictionary? = nil,
             encoding: ParameterEncoding = JSONEncoding.default) {
            
            self.method = method
            self.path = path
            self.encoding = encoding
            self.parameters = parameters
        }
    }
    
    var request: Request {
        switch self {
            
        // Popular
        case .getPopular(let pageValue):
            let parameters: JSONDictionary = ["api_key": Router.apiKey as AnyObject, "page": pageValue as AnyObject]
            return Request(method: .get,
                           path: "/popular",
                           parameters: parameters,
                           encoding: URLEncoding.default)
            
        case .getTopRated(let pageValue):
            let parameters: JSONDictionary = ["api_key": Router.apiKey as AnyObject, "page": pageValue as AnyObject]
            return Request(method: .get,
                           path: "/top_rated",
                           parameters: parameters,
                           encoding: URLEncoding.default)
            
        case .getUpcoming(let pageValue):
            let parameters: JSONDictionary = ["api_key": Router.apiKey as AnyObject, "page": pageValue as AnyObject]
            return Request(method: .get,
                           path: "/upcoming",
                           parameters: parameters,
                           encoding: URLEncoding.default)

        }
    }
}

// MARK: - URLRequestConvertible
extension Router: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLPath)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(request.path))
        urlRequest.httpMethod = request.method.rawValue
        
        if let encoding = request.encoding {
            return try encoding.encode(urlRequest, with: request.parameters)
        } else {
            return urlRequest
        }
    }
}
