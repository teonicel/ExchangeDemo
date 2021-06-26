//
//  ViewController.swift
//  ExchangeDemo
//
//  Created by teo on 02/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit

final class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
   
    private let tableView: UITableView = UITableView(frame: .zero)
    
    public let currencyLabel: UILabel = .exchangeDefault(textAlignment: .left)
    
    public let dateLabel: UILabel = .exchangeDefault(textAlignment: .right)
    
    private let stackView: UIStackView = .horizontalEqual()
    
    var viewModel: CurrencyListViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        viewModel?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.viewDidDisappear()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        tableView.backgroundColor = .white
        stackView.snapMargins(to: view, edges: UIEdgeInsets(margin: 16), except: [.top, .bottom])
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(dateLabel)
        
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.reuseKey)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snapMargins(to: view, edges: .zero, except: [.top])
        
        tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16).isActive = true
        
        let settingsBarButton = UIBarButtonItem(image: UIImage(named: "cogIcon"), style: .plain, target: self, action: #selector(settingTapped))
        navigationItem.leftBarButtonItem = settingsBarButton
        
        let chartsBarButton = UIBarButtonItem(image: UIImage(named: "chartIcon"), style: .plain, target: self, action: #selector(chartsTapped))
               navigationItem.rightBarButtonItem = chartsBarButton
    }
    
    @objc private func settingTapped() {
        viewModel?.settingsTapped()
    }
    
    @objc private func chartsTapped() {
        viewModel?.chartsTapped()
    }
    
    func updateView() {
        tableView.reloadData()
        
        currencyLabel.text = "Current reference: \(viewModel?.rate?.base.rawValue ?? "")"
        currencyLabel.sizeToFit()
        
        dateLabel.text = viewModel?.rate?.date.dateOnly
        dateLabel.sizeToFit()
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
