//
//  HoldingsContentView.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation
import UIKit

final class HoldingsContentView: UIView {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let footerCollapsibleView = HoldingsFooterCollapsibleView()
    var dataSource: UITableViewDataSource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        tableView.backgroundColor = .gray
        setupViews()
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(HoldingsTVC.self, forCellReuseIdentifier: HoldingsTVC.self.description())
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.self.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func config(data: UserHoldingsModel) {
        footerCollapsibleView.config(data: data)
    }
}

private extension HoldingsContentView {
    func setupViews() {
        addSubview(tableView)
        addSubview(footerCollapsibleView)
        
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        footerCollapsibleView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
        }
    }
}
