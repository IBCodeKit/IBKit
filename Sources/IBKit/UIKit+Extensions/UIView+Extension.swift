//
//  UIView+Extension.swift
//  IBKit
//
//  Created by NateKim on 2019/11/05.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

extension UIView {

    public func children(@ViewBuilder builder: () -> Interface) -> Self {
        defer {
            for v in builder().views {
                addSubview(v)
            }
        }
        return self
    }

    public convenience init(@ViewBuilder builder: () -> Interface) {
        self.init(frame: .zero)
        for v in builder().views {
            addSubview(v)
        }
    }

    @discardableResult public func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult public func bounds(_ bounds: CGRect) -> Self {
        self.bounds = bounds
        return self
    }

    @discardableResult public func center(_ center: CGPoint) -> Self {
        self.center = center
        return self
    }

    @discardableResult public func transform(_ transform: CGAffineTransform) -> Self {
        self.transform = transform
        return self
    }

    @available(iOS 12.0, *)
    @discardableResult public func transform3D(_ transform: CATransform3D) -> Self {
        if #available(iOS 13.0, *) {
            self.transform3D = transform
        } else {
            // Fallback on earlier versions
        }
        return self
    }

    @discardableResult public func contentScaleFactor(_ contentScaleFactor: CGFloat) -> Self {
        self.contentScaleFactor = contentScaleFactor
        return self
    }

    @discardableResult public func autoresizesSubviews(_ autoresizesSubviews: Bool) -> Self {
        self.autoresizesSubviews = autoresizesSubviews
        return self
    }

    @discardableResult public func autoresizingMask(_ autoresizingMask: UIView.AutoresizingMask) -> Self {
        self.autoresizingMask = autoresizingMask
        return self
    }

    @discardableResult public func layoutMargins(_ layoutMargins: UIEdgeInsets) -> Self {
        self.layoutMargins = layoutMargins
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult public func directionalLayoutMargins(_ directionalLayoutMargins: NSDirectionalEdgeInsets) -> Self {
        self.directionalLayoutMargins = directionalLayoutMargins
        return self
    }

    @discardableResult public func preservesSuperviewLayoutMargins(_ preservesSuperviewLayoutMargins: Bool) -> Self {
        self.preservesSuperviewLayoutMargins = preservesSuperviewLayoutMargins
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult public func insLayoutMarginsFromSafeArea(_ insetsLayoutMarginsFromSafeArea: Bool) -> Self {
        self.insetsLayoutMarginsFromSafeArea = insetsLayoutMarginsFromSafeArea
        return self
    }

    @discardableResult public func backgroundColor(_ backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    @discardableResult public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult public func isOpaque(_ opaque: Bool) -> Self {
        self.isOpaque = opaque
        return self
    }

    @discardableResult public func clearsContextBeforeDrawing(_ clearsContextBeforeDrawing: Bool) -> Self {
        self.clearsContextBeforeDrawing = clearsContextBeforeDrawing
        return self
    }

    @discardableResult public func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }

    @discardableResult public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    @discardableResult public func mask(_ mask: UIView) -> Self {
        self.mask = mask
        return self
    }

    @discardableResult public func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }

    @discardableResult public func translatesAutoresizingMaskIntoConstraints(_ translatesAutoresizingMaskIntoConstraints: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return self
    }

    @discardableResult public func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        return self
    }

    @discardableResult public func border(color: UIColor, width: CGFloat) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult public func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        return self
    }

    @discardableResult public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }

    @discardableResult public func contentHugging(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult public func contentCompressionResistance(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}

extension NSObjectProtocol {

    @discardableResult public func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self?>, on object: Root) -> Self {
        object[keyPath: keyPath] = self
        return self
    }
}
