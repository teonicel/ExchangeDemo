//
//  SettingsViewModel.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import Foundation

public protocol SettingsNavigable {
    var goBack: (() -> Void)? { get set }
}

public protocol SettingsViewProtocol: AnyObject {
    var viewModel: SettingsViewModelProtocol? { get set }
}

public protocol SettingsViewModelProtocol {
    var managedView: SettingsViewProtocol? { get set }
}

final public class SettingsViewModel: SettingsViewModelProtocol {
    public weak var managedView: SettingsViewProtocol?
    
    private var navigation: SettingsNavigable
    
    init(navigation: SettingsNavigable) {
        self.navigation = navigation
    }
}
