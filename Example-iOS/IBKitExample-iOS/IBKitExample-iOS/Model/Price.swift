//
//  Price.swift
//  IBKitExample-iOS
//
//  Created by NateKim on 2019/12/24.
//  Copyright © 2019 NateKim. All rights reserved.
//

import Foundation

struct Price: Codable {
    let min: Float
    let max: Float
    let originalMin: Float?
    let originalMax: Float?
    let surge: Float?
}

extension Price {

    var priceText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let min = formatter.string(from: self.min as NSNumber) ?? ""
        let max = formatter.string(from: self.max as NSNumber) ?? ""
        return "\(min) - \(max)"
    }

    var originalPriceText: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        guard let min = originalMin.flatMap({ formatter.string(from: $0 as NSNumber) }),
            let max = originalMax.flatMap({ formatter.string(from: $0 as NSNumber) })
            else { return nil }
        return "\(min) - \(max)"

    }

    var surgeText: String? {
        return surge.map { "\($0)x" }
    }
}
