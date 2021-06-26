//
//  Coordinator.swift
//  ExchangeDemo
//
//  Created by teo on 03/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation
import UIKit

final public class AppCoordinator: Coordinator {
    let sceneFactory: SceneModuleFactoryProtocol
    
    init(router: UINavigationController?, sceneFactory: SceneModuleFactoryProtocol) {
        self.sceneFactory = sceneFactory
        super.init(router: router)
    }
    
    override func start() {
        var module = sceneFactory.makeExchangeListModule()
        module.nav.goToCurrencyHistory = { [weak self] in
            self?.goToCurrencyHistory()
        }
        module.nav.goToSettings = { [weak self] in
            self?.goToSettings()
        }
        module.nav.goToError = { [weak self] error in
            self?.goToError(error: error)
        }
        guard let viewController = module.vc.toPresent() else { return }
        router.setViewControllers([viewController], animated: true)
    }
    
    private func goToCurrencyHistory() {
        var module = sceneFactory.makeExchangeHistoryModule()
        module.nav.goBack = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        module.nav.goToError = { [weak self] error in
            self?.goToError(error: error)
        }
        guard let viewController = module.vc.toPresent() else { return }
        router.pushViewController(viewController, animated: true)
    }
    
    private func goToSettings() {
        var module = sceneFactory.makeSettingsModule()
        module.nav.goBack = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        guard let viewController = module.vc.toPresent() else { return }
        router.pushViewController(viewController, animated: true)
    }
}
