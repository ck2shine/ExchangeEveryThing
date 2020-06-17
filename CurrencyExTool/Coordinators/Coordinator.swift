//
//  Coordinator.swift
//  Copyright © 2020 Shine. All rights reserved.
//

import  UIKit
class Coordinator<T:UIViewController> :  CoordinatorProtocol{

    var childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol]()

    weak final var parentCoordinator: CoordinatorProtocol?

    private(set) var started : Bool = false


    func start() {
        started = true
    }

    func stop() {
        started = false
        stopAllChildCoordinator()
    }

    var presenter : T?


    init(presenter : T?) {
        self.presenter = presenter
    }

    final func startChildCoordinator(coordinator : CoordinatorProtocol){
        guard !childCoordinators.contains(where: {$0 === coordinator}) else{
            return
        }
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    final func stopChildCoordinator(coordinator : CoordinatorProtocol){

        //stop all child coordinator or input coordinator
        coordinator.stop()
        //remove coordinator from current coordinator`s childcoordinators
        if let index = childCoordinators.firstIndex(where: {$0 === coordinator}){
            childCoordinators.remove(at: index)
        }
    }

    final func stopAllChildCoordinator(){
        childCoordinators.forEach {
            $0.stop()
        }
        childCoordinators.removeAll()
    }

    func debugCoordinatorHierarchy(){
        print(" main child coordinators : \(childCoordinators)")
    }


    deinit {
        print("the coordinate \(String(describing: self)) dealloc")
    }


}


extension Coordinator where T:UINavigationController{
    final func show(to viewcontroller : UIViewController , animated : Bool = true){
        //put coordinator into viewcontroller
        viewcontroller.coordinator = self
        presenter?.pushViewController(viewcontroller, animated: animated)
    }

    final func pop(to coordinator : CoordinatorProtocol, animated : Bool = true){
        //get all coordinator in navigation viewcontroller stack
        let allCoordinators = presenter?.viewControllers.compactMap({
            $0.coordinator
        })

        //find first match coordinator
        guard let index = allCoordinators?.firstIndex(where: { $0 ===  coordinator}) else {
            return
        }

        if let popToViewController = presenter?.viewControllers[index]{
            presenter?.popToViewController(popToViewController, animated: animated)
        }
    }
}
