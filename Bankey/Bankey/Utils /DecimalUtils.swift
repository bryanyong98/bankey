//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Bryan Yong on 12/09/2022.
//

import Foundation

extension Decimal {
    var doubleValue : Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
