//
//  HoldingsVC.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation
import UIKit

final class HoldingsVC: BaseVC<HoldingsHeaderView, HoldingsContentView, HoldingsVM> {
    override init(with viewModel: HoldingsVM) {
        super.init(with: viewModel)
        viewModel.delegate = self
        contentView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func onAPIResponse(data: Decodable) {
        guard let data = data as? UserHoldingsModel else {
            print("Invalid data")
            return
        }
        contentView.config(data: data)
        contentView.reloadTableView()
    }
}

extension HoldingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data?.userHolding.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingsTVC.self.description(), for: indexPath) as? HoldingsTVC,
              let data = viewModel.data?.userHolding[indexPath.row] else {
            return UITableViewCell(frame: .zero)
        }
        cell.config(topLeftText: data.symbol,
                    topRightText: String(format: "LTP: ₹%0.2f", data.ltp),
                    bottomLeftText: "\(data.quantity)",
                    bottomRightText: String(format: "P/L: ₹%0.2f", data.pl))
        return cell
    }
}
