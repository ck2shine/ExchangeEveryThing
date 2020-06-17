//
//  CoordinatorProtocol.swift
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
protocol CoordinatorProtocol : class {

    var parentCoordinator: CoordinatorProtocol? { get set }
    var childCoordinators: [CoordinatorProtocol] { get }
    func start()
    func stop()
    func debugCoordinatorHierarchy()
}

private struct CoordinatorAssociatedKeys{
    static var storeKey : UInt = 0
}


extension UIViewController{
    weak var coordinator : CoordinatorProtocol? {
        set{
            objc_setAssociatedObject(self, &CoordinatorAssociatedKeys.storeKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return objc_getAssociatedObject(self, &CoordinatorAssociatedKeys.storeKey) as? CoordinatorProtocol
        }
    }
}
