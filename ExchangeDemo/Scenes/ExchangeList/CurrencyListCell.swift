//
//  CurrencyListCell.swift
//  ExchangeDemo
//
//  Created by teo on 03/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit

class CurrencyListCell: UITableViewCell {
    public let currencyLabel: UILabel = .exchangeDefault(textAlignment: .left)
    
    public let amountLabel: UILabel = .exchangeDefault(textAlignment: .right)
    
    private let stackView: UIStackView = .horizontalEqual()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(stackView)
        stackView.snapMargins(to: contentView, edges: UIEdgeInsets(margin: 16))
        
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(amountLabel)
        
        layoutIfNeeded()
    }
    
    public func config(with data: [Currency: Decimal]) {
        currencyLabel.text = data.keys.first?.rawValue ?? ""
        amountLabel.text = (data.values.first ?? 0).twoDigitsString
        currencyLabel.sizeToFit()
        amountLabel.sizeToFit()
    }
}
