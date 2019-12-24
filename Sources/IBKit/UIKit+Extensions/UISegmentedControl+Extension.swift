//
//  UISegmentedControl+Extension.swift
//  IBKit
//
//  Created by NateKim on 2019/12/10.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit

extension UISegmentedControl {

    public enum SegmentItem {
        case title(String)
        case image(UIImage)
    }

    public convenience init(segments: [SegmentItem]) {
        self.init(frame: .zero)
        for item in segments.reversed() {
            switch item {
            case .title(let title):
                insertSegment(withTitle: title, at: 0, animated: false)
            case .image(let image):
                insertSegment(with: image, at: 0, animated: false)
            }
        }
    }

    @discardableResult public func isMomentary(_ isMomentary: Bool) -> Self {
        return self
    }

    @discardableResult public func apportionsSegmentWidthsByContent(_ apportionsSegmentWidthsByContent: Bool) -> Self {
        self.apportionsSegmentWidthsByContent = apportionsSegmentWidthsByContent
        return self
    }

    @discardableResult public func title(_ title: String?, forSegmentAt segment: Int) -> Self {
        setTitle(title, forSegmentAt: segment)
        return self
    }

    @discardableResult public func image(_ image: UIImage?, forSegmentAt segment: Int) -> Self {
        setImage(image, forSegmentAt: segment)
        return self
    }

    @discardableResult public func  width(_ width: CGFloat, forSegmentAt segment: Int) -> Self {
        setWidth(width, forSegmentAt: segment)
        return self
    }

    @discardableResult public func contentOffset(_ offset: CGSize, forSegmentAt segment: Int) -> Self {
        setContentOffset(offset, forSegmentAt: segment)
        return self
    }

    @discardableResult public func enabled(_ enabled: Bool, forSegmentAt segment: Int) -> Self {
        setEnabled(enabled, forSegmentAt: segment)
        return self
    }

    @discardableResult public func selectedSegmentIndex(_ selectedSegmentIndex: Int) -> Self {
        self.selectedSegmentIndex = selectedSegmentIndex
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult public func selectedSegmentTintColor(_ selectedSegmentTintColor: UIColor) -> Self {
        self.selectedSegmentTintColor = selectedSegmentTintColor
        return self
    }

    @discardableResult public func backgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State, barMetrics: UIBarMetrics) -> Self {
        setBackgroundImage(backgroundImage, for: state, barMetrics: barMetrics)
        return self
    }

    @discardableResult public func dividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftState: UIControl.State, rightSegmentState rightState: UIControl.State, barMetrics: UIBarMetrics) -> Self {
        setDividerImage(dividerImage, forLeftSegmentState: leftState, rightSegmentState: rightState, barMetrics: barMetrics)
        return self
    }

    @discardableResult public func titleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) -> Self {
        setTitleTextAttributes(attributes, for: state)
        return self
    }

    @discardableResult public func contentPositionAdjustment(_ adjustment: UIOffset, forSegmentType leftCenterRightOrAlone: UISegmentedControl.Segment, barMetrics: UIBarMetrics) -> Self {
        setContentPositionAdjustment(adjustment, forSegmentType: leftCenterRightOrAlone, barMetrics: barMetrics)
        return self
    }
}
