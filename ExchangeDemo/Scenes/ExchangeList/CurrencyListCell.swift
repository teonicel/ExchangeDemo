//
//  CurrencyListCell.swift
//  ExchangeDemo
//
//  Created by teo on 03/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit

class CurrencyListCell: UITableViewCell {
    public let currencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    public let amountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.textColor = .black
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
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
        amountLabel.text = NumberFormatter.currency.string(for: data.values.first ?? 0)
        currencyLabel.sizeToFit()
        amountLabel.sizeToFit()
    }
}
