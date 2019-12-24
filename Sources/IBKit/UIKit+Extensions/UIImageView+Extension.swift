//
//  UIImageView+Extension.swift
//  IBKit
//
//  Created by NateKim on 2019/11/06.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

extension UIImageView {

    @discardableResult public func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult public func highlightedImage(_ highlightedImage: UIImage?) -> Self {
        self.highlightedImage = highlightedImage
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult public func preferredSymbolConfiguration(_ preferredSymbolConfiguration: UIImage.SymbolConfiguration?) -> Self {
        self.preferredSymbolConfiguration = preferredSymbolConfiguration
        return self
    }

    @discardableResult public func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }

    @discardableResult public func animationImages(_ animationImages: [UIImage]?) -> Self {
        self.animationImages = animationImages
        return self
    }

    @discardableResult public func highlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) -> Self {
        self.highlightedAnimationImages = highlightedAnimationImages
        return self
    }

    @discardableResult public func animationDuration(_ animationDuration: TimeInterval) -> Self {
        self.animationDuration = animationDuration
        return self
    }

    @discardableResult public func animationRepeatCount(_ animationRepeatCount: Int) -> Self {
        self.animationRepeatCount = animationRepeatCount
        return self
    }

    @discardableResult public func tint(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
}
