//
//  LocalizableString.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation

enum LocalizableString: String {
    
    //MARK: - Global
    case movies = "Movies"
    case ok = "Ok" 
    //MARK: - Home
    case topRated = "Top rated"
    case popular = "Popular"
    case upcoming = "Upcoming"
    case search = "Search"
    
    //MARK: - Errors
    case connectionError = "Connection error"
    case connectionProblem = "There was a problem, please try again."
    case offlineError = "Offline error"
    case checkInternet = "Check your internet connection and try again."
    case fillInformation = "Please complete all the information to proceed"

    var localizedString: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
