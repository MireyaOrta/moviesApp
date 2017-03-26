//
//  AppCoordinator.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Private Properties
    fileprivate var window: UIWindow
    fileprivate var coordinators: CoordinatorsDictionary
    
    // MARK: - Properties
    var rootViewController: UIViewController {
        let coordinator = coordinators.popFirst()!.1
        return coordinator.rootViewController
    }
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    func start() {
        showHome()
    }
    
    // MARK: Helpers
    fileprivate func showHome() {
        let homeCoordinator = HomeCoordinator()
        //        homeCoordinator.delegate = self
        coordinators[String(describing: homeCoordinator)] = homeCoordinator
        window.rootViewController = homeCoordinator.rootViewController
        homeCoordinator.start()
    }
}
