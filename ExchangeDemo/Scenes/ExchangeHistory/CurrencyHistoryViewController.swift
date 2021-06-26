//
//  CurrencyHistory.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit

class CurrencyHistoryViewController: UIViewController, CurrencyHistoryViewProtocol {
    var viewModel: CurrencyHistoryViewModelProtocol?
    
    private let tableView: UITableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        viewModel?.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        tableView.register(CurrencyHistoryCell.self, forCellReuseIdentifier: CurrencyHistoryCell.reuseKey)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snapMargins()
    }
    
    func updateView() {
        tableView.reloadData()
    }
}

extension CurrencyHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.currencies[safe: section]?.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyHistoryCell.reuseKey, for: indexPath)
        if let currency = viewModel?.currencies[safe: indexPath.section],
            let cellData = viewModel?.chartData(for: currency),
            let currencyCell = cell as? CurrencyHistoryCell {
            
            currencyCell.config(with: cellData.chartSeries, labels: cellData.labels)
            return currencyCell
        }
        return cell
    }
}
