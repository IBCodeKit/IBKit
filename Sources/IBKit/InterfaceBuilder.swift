//
//  InterfaceBuilder.swift
//  IBKit
//
//  Created by NateKim on 2019/12/10.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

/// A builder that constructs user interfaces.
///
/// You create custom view by declaring type that conform to the InterfaceBuilder protocol. Implement the required body computed property to provide the content for your custom view.
public protocol InterfaceBuilder {
    var body: Interface { get }
}

extension InterfaceBuilder where Self: UIView {

    /// Returns a newly initialized view with the InterfaceBuilder's body.
    static func loadFromIB() -> Self {
        let this = Self.init()
        this.build()
        return this
    }

    /// Builds and attaches subviews according to the InterfaceBuilder's body.
    public func build() {
        let views = body.views
        for v in views {
            addSubview(v)
        }
        finishBuild(on: self)
    }
}

extension InterfaceBuilder where Self: UIViewController {

    /// Returns a newly initialized view controller with the InterfaceBuilder's body.
    static func loadFromIB() -> Self {
        let this = Self.init()
        this.build()
        return this
    }

    /// Builds and attaches subviews according to the InterfaceBuilder's body.
    public func build() {
        let views = body.views
        for v in views {
            view.addSubview(v)
        }
        view.finishBuild(on: view)
    }
}
