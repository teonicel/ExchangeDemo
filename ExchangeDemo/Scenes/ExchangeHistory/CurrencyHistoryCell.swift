//
//  CurrencyHistoryCell.swift
//  ExchangeDemo
//
//  Created by teo on 06/04/2020.
//  Copyright © 2020 teonicel. All rights reserved.
//

import UIKit

class CurrencyHistoryCell: UITableViewCell {
    let chart = Chart(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(chart)
        chart.snapMargins(to: contentView, edges: UIEdgeInsets(margin: 16))
        chart.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    public func config(with series: ChartSeries, labels: [String]) {
        chart.xLabelsFormatter = { labelIndex, labelValue -> String in
            labels[safe: labelIndex] ?? ""
        }
        chart.yLabelsFormatter = { labelIndex, labelValue -> String in
            NumberFormatter.fourDigits.string(for: labelValue) ?? ""
        }
        chart.add(series)
    }
}
