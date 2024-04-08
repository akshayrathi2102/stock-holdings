//
//  HoldingsVM.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation

final class HoldingsVM: BaseVM<UserHoldingsModel> {
    
    override func fetchData() {
        delegate?.showLoader(true)
        NetworkManager.shared.fetchData(HoldingsRouter(), completionHandler: {
            [weak self] (holdingsResult: Result<UserHoldingsModel, Errors>) in
            switch holdingsResult {
            case .success(let success):
                self?.data = success
                self?.delegate?.onAPIResponse(data: success)
            case .failure(let failure):
                self?.delegate?.onError(error: failure)
            }
            self?.delegate?.showLoader(false)
        })
    }
}
