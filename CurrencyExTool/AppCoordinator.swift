//
//  AppCoordinator.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator : Coordinator<UIViewController>{
    var window : UIWindow?


    init(window : UIWindow){
        self.window = window
        super.init(presenter: nil)
    }

    override func start() {
        
        let navigationVC = UINavigationController()
        let dependency = CurrencyMainDependency()
        let mainPageCoordinator = CurrencyMainPageCoordinator(navigationVC , dependency: dependency)
              
        self.window?.rootViewController = navigationVC
        startChildCoordinator(coordinator: mainPageCoordinator)
        
        super.start()
    }
}
