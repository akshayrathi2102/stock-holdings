//
//  HoldingsModel.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation


//{
//    "symbol": "TCS",
//    "quantity": 10,
//    "ltp": 3250.50,
//    "avgPrice": 2480.30,
//    "close": 3312
//}

struct UserHoldingsModel: Decodable {
    let userHolding: [HoldingsModel]
    
    var currentTotalValue: Double {
        return userHolding.reduce(into: 0.0) { partialResult, holding in
            partialResult += holding.currentValue
        }
    }
    
    var totalInvestment: Double {
        return userHolding.reduce(into: 0.0) { partialResult, holding in
            partialResult += holding.investmentValue
        }
    }
    
    var totalPl: Double {
        return currentTotalValue - totalInvestment
    }
    
    var todayPl: Double {
        return userHolding.reduce(into: 0.0) { partialResult, holding in
            partialResult += ((holding.close - holding.ltp) * Double(holding.quantity))
        }
    }
}

struct HoldingsModel: Decodable {
    let symbol: String
    let quantity: UInt
    let ltp: Double
    let avgPrice: Double
    // not sure what is this
    let close: Double
    
    var currentValue: Double {
        return ltp * Double(quantity)
    }
    
    var investmentValue: Double {
        return avgPrice * Double(quantity)
    }
    
    var pl: Double {
        return currentValue - investmentValue
    }
}
