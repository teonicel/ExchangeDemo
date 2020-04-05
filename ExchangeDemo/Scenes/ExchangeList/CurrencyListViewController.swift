//
//  ViewController.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit
import RxSwift

final class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    var viewModel: CurrencyListViewModelProtocol?
    private let tableView: UITableView = UITableView(frame: .zero)
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        viewModel?.viewDidLoad()
    }
    
    private func setupView() {
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.reuseKey)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snapMargins()
        
        viewModel?.error.subscribe(onNext: { error in
            
        }).disposed(by: bag)
        
        let settingsBarButton = UIBarButtonItem(image: UIImage(named: "cogIcon"), style: .plain, target: self, action: #selector(settingTapped))
    }
    
    @objc private func settingTapped() {
        viewModel?.settingsTapped()
    }
    
    func updateTable() {
        tableView.reloadData()
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.rateSelected(indexPath: indexPath)
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rate?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.reuseKey, for: indexPath)
        if let cellData = viewModel?.rate?.rates[safe: indexPath.row], let currencyCell = cell as? CurrencyListCell {
            currencyCell.config(with: cellData)
            return currencyCell
        }
        return cell
    }
}
