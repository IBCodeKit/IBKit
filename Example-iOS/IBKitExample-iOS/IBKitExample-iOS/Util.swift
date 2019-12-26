//
//  Util.swift
//  IBKitExample-iOS
//
//  Created by NateKim on 2019/12/24.
//  Copyright © 2019 NateKim. All rights reserved.
//

import Foundation

func decode<T: Codable>(from resource: String) -> T? {
    guard let url = Bundle.main.url(forResource: resource, withExtension: "json"),
        let data = try? Data(contentsOf: url) else { return nil }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return (try? decoder.decode(T.self, from: data))
}

import UIKit
import SnapKit
import IBKit

extension UIView {
    func makeConstraints(_ maker: @escaping (ConstraintMaker, Views) -> Void) -> Self {
        return didAwakeFromBuilder { views in
            views.this.snp.makeConstraints { maker($0, views) }
        }
    }
}

protocol ScopedFunctions {}

extension ScopedFunctions {
    func also(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: ScopedFunctions {}
