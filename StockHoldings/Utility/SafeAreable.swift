//
//  SafeAreable.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 22/02/24.
//

import Foundation
import UIKit

protocol SafeAreable {}

extension SafeAreable {
    var safeAreaInsets: UIEdgeInsets {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets ?? .zero
    }
}
