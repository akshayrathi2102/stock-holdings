//
//  HoldingsLeftRightView.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation
import UIKit

final class HoldingsLeftRightView: UIView {
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(leftTitle: String?, rightTitle: String?, shouldBoldRightText: Bool = false) {
        leftLabel.text = leftTitle
        rightLabel.text = rightTitle
        if shouldBoldRightText {
            leftLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
}

private extension HoldingsLeftRightView {
    func setupViews() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        
        leftLabel.textAlignment = .left
        leftLabel.numberOfLines = 1
        leftLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        rightLabel.textAlignment = .right
        rightLabel.numberOfLines = 1
        rightLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        rightLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.leading.greaterThanOrEqualTo(leftLabel.snp.trailing)
        }
    }
}
