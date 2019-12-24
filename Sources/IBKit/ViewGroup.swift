//
//  ViewGroup.swift
//  IBKit
//
//  Created by NateKim on 2019/12/10.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

/// A special interface that can contain other views.
public struct ViewGroup: Interface {

    private let children: [UIView]

    public init(@ViewBuilder builder: () -> Interface) {
        self.children = builder().views
    }

    internal init(children: [UIView]) {
        self.children = children
    }

    public var views: [UIView] {
        children
    }
}
