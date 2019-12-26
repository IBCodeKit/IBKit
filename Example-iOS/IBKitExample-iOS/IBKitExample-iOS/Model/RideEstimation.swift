//
//  RideEstimation.swift
//  IBKitExample-iOS
//
//  Created by NateKim on 2019/12/24.
//  Copyright © 2019 NateKim. All rights reserved.
//

import Foundation

struct RideEstimation: Codable {
    let type: RideType
    let price: Price
}

enum RideType: String, Codable {
    case basic = "BASIC"
    case premium = "PREMIUM"
    case assist = "ASSIST"
    case vipvan = "VIPVAN"

    var name: String {
        switch self {
        case .basic:
            return "Basic"
        case .premium:
            return "Premium"
        case .assist:
            return "Assist"
        case .vipvan:
            return "VIPVan"
        }
    }

    var image: String {
        switch self {
        case .basic:
            return "ic_thumbnail_basic"
        case .premium:
            return "ic_thumbnail_premium"
        case .assist:
            return "ic_thumbnail_assist"
        case .vipvan:
            return "ic_thumbnail_vipvan"
        }
    }

    var passengers: String {
        switch self {
        case .basic:
            return "1-7"
        case .premium:
            return "1-3"
        case .assist:
            return "1-3"
        case .vipvan:
            return "1-11"
        }
    }

    var additionalText: String? {
        if self == .assist {
            return "Beta"
        } else if self == .vipvan {
            return "Reservation only"
        }
        return nil
    }
}
