//
//  UISlider+Extension.swift
//  IBKit
//
//  Created by NateKim on 2019/12/10.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

extension UISlider {

    @discardableResult public func value(_ value: Float) -> Self {
        self.value = value
        return self
    }

    @discardableResult public func minimumValue(_ minimumValue: Float) -> Self {
        self.minimumValue = minimumValue
        return self
    }

    @discardableResult public func maximumValue(_ maximumValue: Float) -> Self {
        self.maximumValue = maximumValue
        return self
    }

    @discardableResult public func minimumValueImage(_ minimumValueImage: UIImage?) -> Self {
        self.minimumValueImage = minimumValueImage
        return self
    }

    @discardableResult public func maximumValueImage(_ maximumValueImage: UIImage?) -> Self {
        self.maximumValueImage = maximumValueImage
        return self
    }

    @discardableResult public func isContinuous(_ isContinuous: Bool) -> Self {
        self.isContinuous = isContinuous
        return self
    }

    @discardableResult public func minimumTrackTintColor(_ minimumTrackTintColor: UIColor?) -> Self {
        self.minimumTrackTintColor = minimumTrackTintColor
        return self
    }

    @discardableResult public func maximumTrackTintColor(_ maximumTrackTintColor: UIColor?) -> Self {
        self.maximumTrackTintColor = maximumTrackTintColor
        return self
    }

    @discardableResult public func thumbTintColor(_ thumbTintColor: UIColor?) -> Self {
        self.thumbTintColor = thumbTintColor
        return self
    }

    @discardableResult public func value(_ value: Float, animated: Bool) -> Self {
        setValue(value, animated: animated)
        return self
    }

    @discardableResult public func thumbImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        setThumbImage(image, for: state)
        return self
    }

    @discardableResult public func minimumTrackImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        setMinimumTrackImage(image, for: state)
        return self
    }

    @discardableResult public func maximumTrackImage(_ image: UIImage?, for state: UIControl.State) -> Self {
        setMaximumTrackImage(image, for: state)
        return self
    }
}
