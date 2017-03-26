//
//  Coordinators.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

typealias CoordinatorsDictionary = [String: Coordinator]

protocol Coordinator {
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    static var name: String {
        return String(describing: self)
    }
}
