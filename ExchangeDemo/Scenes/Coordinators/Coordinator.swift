//
//  Coordinator.swift
//  ExchangeDemo
//
//  Created by teo on 03/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    @discardableResult func start()
}

public class Coordinator: CoordinatorProtocol {
    var childCoordinators = NSMutableOrderedSet()
    var router: UINavigationController
    
    init(router: UINavigationController?) {
        self.router = router ?? UINavigationController()
    }
    
    func start() {
        
    }
    
    // add only unique object
    func addDependency(_ coordinator: Coordinator) {
        childCoordinators.add(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator) {
        childCoordinators.remove(coordinator)
    }
}
