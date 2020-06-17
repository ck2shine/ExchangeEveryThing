//
//  AppCoordinator.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/17.
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
        super.start()




//        let navigationVC = UINavigationController(rootViewController: )
//        self.window?.rootViewController = navigationVC
    }
}
