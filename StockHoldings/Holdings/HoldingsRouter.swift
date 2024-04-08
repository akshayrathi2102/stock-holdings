//
//  HoldingsRouter.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation

struct HoldingsRouter: API {
    
 // https://run.mocky.io/v3/bde7230e-bc91-43bc-901d-c79d008bddc8
    
    var baseUrl: String {
        return "run.mocky.io"
    }
    
    var path: String {
        return "/v3/bde7230e-bc91-43bc-901d-c79d008bddc8"
    }
    
    var queryParams: [String : String]? = nil
}
