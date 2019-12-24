//
//  Interface.swift
//  IBKit
//
//  Created by NateKim on 2019/12/10.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

/// A type that represents an IBKit's Interface.
public protocol Interface {
    var views: [UIView] { get }
}

extension UIView: Interface {
    public var views: [UIView] { [self] }
}
