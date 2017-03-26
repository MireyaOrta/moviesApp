//
//  ErrorPresentable.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import Foundation

protocol ErrorPresentable: Error {
    var title: String? { get }
    var message: String? { get }
}
