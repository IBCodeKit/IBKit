//
//  UIView+IBKit.swift
//  IBKit
//
//  Created by NateKim on 2019/11/05.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

private var identifierKey: UInt8 = 0
private var awakeCallbackKey: UInt8 = 0
extension UIView {

    /// The identifier for the view. 
    /// - Parameter value: The identifier.
    /// 
    /// This identifier is valid only within the interface builder.
    @discardableResult public func identifier(_ value: String?) -> Self {
        self.identifier = value
        return self
    }

    internal var identifier: String? {
        get {
            objc_getAssociatedObject(self, &identifierKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &identifierKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    /// Callback after the view has been loaded and attached from an Interface Builder on IBKit
    ///
    /// - Parameter closure: A closure that takes all views in the interface builder
    public func didAwakeFromBuilder(_ closure: @escaping (Views) -> Void) -> Self {
        pushAwakeCallback(closure)
        return self
    }

    private func setAwakeCallbacks(_ value: [((Views) -> Void)]) {
        objc_setAssociatedObject(self, &awakeCallbackKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    private var awakeCallbacks: [((Views) -> Void)] {
        objc_getAssociatedObject(self, &awakeCallbackKey) as? [((Views) -> Void)] ?? []
    }

    private func pushAwakeCallback(_ callback: @escaping (Views) -> Void) {
        var callbacks = awakeCallbacks
        callbacks.append(callback)
        setAwakeCallbacks(callbacks)
    }

    private func popAwakeCallback() -> ((Views) -> Void)? {
        var callbacks = awakeCallbacks
        defer {
            setAwakeCallbacks(callbacks)
        }
        return callbacks.popLast()
    }

    private func runCallback(with root: UIView) {
        for v in subviews {
            while let callback = v.popAwakeCallback() {
                callback(Views(root: root, current: v))
            }
            v.runCallback(with: root)
        }
    }

    private func flushIdentifier() {
        for v in subviews {
            v.identifier = nil
            v.flushIdentifier()
        }
    }

    internal func finishBuild(on root: UIView) {
        runCallback(with: root)
        flushIdentifier()
    }

    internal func findViewBy(id: String) -> UIView? {
        if identifier == id {
            return self
        }
        for sub in subviews {
            if let v = sub.findViewBy(id: id) {
                return v
            }
        }
        return nil
    }
}
