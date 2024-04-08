//
//  BaseVMDelegate.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 22/02/24.
//

import Foundation

protocol BaseVMDelegate: AnyObject {
    func showLoader(_ show: Bool)
    func onAPIResponse(data: Decodable)
    func onError(error: Errors)
}
