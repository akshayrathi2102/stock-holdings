//
//  HoldingsTVC.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation
import UIKit
import SnapKit

final class HoldingsTVC: UITableViewCell {
    private let topLeftRightView = HoldingsLeftRightView()
    private let bottomLeftRightView = HoldingsLeftRightView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(topLeftText: String?,
                topRightText: String?,
                bottomLeftText: String?,
                bottomRightText: String?) {
        topLeftRightView.config(leftTitle: topLeftText, rightTitle: topRightText, shouldBoldRightText: true)
        bottomLeftRightView.config(leftTitle: bottomLeftText, rightTitle: bottomRightText)
    }
}

private extension HoldingsTVC {
    func setupViews() {
        contentView.addSubview(topLeftRightView)
        contentView.addSubview(bottomLeftRightView)
        
        topLeftRightView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(12)
        }
        
        bottomLeftRightView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(12)
            make.top.equalTo(topLeftRightView.snp.bottom).offset(12)
        }
    }
}
