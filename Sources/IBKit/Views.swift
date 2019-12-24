//
//  Views.swift
//  IBKit
//
//  Created by NateKim on 2019/12/10.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

/// A view accessor within the current interface builder.
@dynamicMemberLookup public struct Views {

    private let root: UIView
    private let current: UIView
    internal init(root: UIView, current: UIView) {
        self.root = root
        self.current = current
    }

    /// The view itself
    public var this: UIView { current }

    /// The view’s superview
    public var superview: UIView { current.superview! }

    /// The layout guide representing the portion of interface builder's root view that is unobscured by bars and other content.
    @available(iOS 11.0, *)
    public var safeAreaLayoutGuide: UILayoutGuide { root.safeAreaLayoutGuide }

    /// Finds a view named `id`.
    public subscript(dynamicMember id: String) -> UIView {
        let view = root.findViewBy(id: id)
        assert(view != nil, "Could not find the view named (\(id)).")
        return view!
    }
}
