//
//  HomeCoordinator.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    var rootViewController: UIViewController
    fileprivate var coordinators: [String: Coordinator]
    
    fileprivate var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    // MARK: - Initializers
    init() {
        rootViewController = UINavigationController()
        coordinators = [:]
    }
    
    func start() {
        let homeVC = HomeViewController()
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
}

