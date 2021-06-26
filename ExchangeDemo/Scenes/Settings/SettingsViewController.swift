//
//  Settings.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {
    var viewModel: SettingsViewModelProtocol?
    
    private let currencyPickerLabel: UILabel = .exchangeDefault()
    
    private let currencyPickerView = UIPickerView()
    
    private let refreshLabel: UILabel = .exchangeDefault()
    
    private let refreshSegmentedControl = UISegmentedControl()
    
    private let stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        viewModel?.viewDidLoad()
    }
    
    private func setupView() {
        view.addSubview(stackView)
        stackView.snapMargins(to: view, edges: UIEdgeInsets(margin: 16), except: [.top, .bottom])
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        currencyPickerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        currencyPickerLabel.text = "Pick base currency"
        currencyPickerLabel.sizeToFit()
        
        refreshLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        refreshLabel.text = "Pick home refresh rate"
        refreshLabel.sizeToFit()
        
        stackView.addArrangedSubview(currencyPickerLabel)
        stackView.addArrangedSubview(currencyPickerView)
        stackView.addArrangedSubview(refreshLabel)
        stackView.addArrangedSubview(refreshSegmentedControl)
        
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
        refreshSegmentedControl.addTarget(self, action: #selector(onRefreshTimeChanged), for: .valueChanged)
    }
    
    @objc private func onRefreshTimeChanged() {
        viewModel?.refreshTimeChanged(index: refreshSegmentedControl.selectedSegmentIndex)
    }
    
    func updateView() {
        currencyPickerView.reloadAllComponents()
        currencyPickerView.selectRow(viewModel?.selectedCurrencyIndex ?? 0, inComponent: 0, animated: false)
        
        refreshSegmentedControl.removeAllSegments()
        viewModel?.refreshRates.forEach {
            refreshSegmentedControl.insertSegment(withTitle: $0.description, at: refreshSegmentedControl.numberOfSegments, animated: true)
        }
        refreshSegmentedControl.selectedSegmentIndex = viewModel?.selectedRefreshIndex ?? 0
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.currencySelected(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.currencies[safe: row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.currencies.count ?? 0
    }
}
