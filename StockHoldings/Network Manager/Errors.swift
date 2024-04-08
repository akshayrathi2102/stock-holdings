//
//  Errors.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 24/02/24.
//

import Foundation

enum Errors: String, Error {
    case genericError = "Something went wrong"
    case invalidUrl = "Invalid URL"
    case dataDoNotExist = "Data do not exist"
    case invalidDataFormat = "Invalid data format"
}
