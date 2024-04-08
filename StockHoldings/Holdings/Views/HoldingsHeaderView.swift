//
//  HoldingsHeaderView.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation
import UIKit
import SnapKit

final class HoldingsHeaderView: UIView {
    private let label = UILabel(frame: .zero)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        config(title: StringConstants.upstoxHolding,
               titleTextColor: .white,
               backgroundColor: .purple)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HoldingsHeaderView {
    func setupViews() {
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
    }
    
    func config(title: String,
                titleTextColor: UIColor?,
                backgroundColor: UIColor?) {
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = titleTextColor
        self.backgroundColor = backgroundColor
    }
}
