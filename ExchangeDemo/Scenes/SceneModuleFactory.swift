//
//  SceneModuleFactory.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

protocol SceneModuleFactoryProtocol {
    func makeExchangeListModule() -> (vc: Presentable, nav: CurrencyListNavigable)
    func makeExchangeHistoryModule() -> (vc: Presentable, nav: CurrencyHistoryNavigable)
    func makeSettingsModule() -> (vc: Presentable, nav: SettingsNavigable)
}

final public class SceneModuleFactory: SceneModuleFactoryProtocol {
    
    func makeExchangeListModule() -> (vc: Presentable, nav: CurrencyListNavigable) {
        final class CurrencyListNav: CurrencyListNavigable {
            var goToCurrencyHistory: (() -> Void)?
            var goToSettings: (() -> Void)?
        }
        let nav = CurrencyListNav()
        let vm = CurrencyListViewModel(navigation: nav)
        let vc = CurrencyListViewController()
        vm.managedView = vc
        vc.viewModel = vm
        return (vc, nav)
    }
    
    func makeExchangeHistoryModule() -> (vc: Presentable, nav: CurrencyHistoryNavigable) {
        final class CurrencyHistoryNav: CurrencyHistoryNavigable {
            var goBack: (() -> Void)?
        }
        let nav = CurrencyHistoryNav()
        let vm = CurrencyHistoryViewModel(navigation: nav)
        let vc = CurrencyHistoryViewController()
        vm.managedView = vc
        vc.viewModel = vm
        return (vc, nav)
    }
    
    func makeSettingsModule() -> (vc: Presentable, nav: SettingsNavigable) {
        final class SettingstNav: SettingsNavigable {
            var goBack: (() -> Void)?
        }
        let nav = SettingstNav()
        let vm = SettingsViewModel(navigation: nav)
        let vc = SettingsViewController()
        vm.managedView = vc
        vc.viewModel = vm
        return (vc, nav)
    }
}
