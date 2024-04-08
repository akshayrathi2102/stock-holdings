//
//  BaseVM.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 22/02/24.
//

import Foundation

protocol BaseAPIVM {
    func fetchData()
}

class BaseVM<Model: Decodable>: BaseAPIVM {
    var data: Model?
    weak var delegate: BaseVMDelegate?
    
    func fetchData() {}
}
