//
//  PriceView.swift
//  IBKitExample-iOS
//
//  Created by NateKim on 2019/12/24.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit
import IBKit

class PriceView: UIView, InterfaceBuilder {

    private var surgeTextLabel: UILabel!
    private var priceLabel: UILabel!
    private var originalPriceLabel: UILabel!

    var price: Price? {
        didSet {
            surgeTextLabel.text = price?.surgeText
            surgeTextLabel.textColor = (price?.surge ?? 1 > 1) ? .systemRed : .systemBlue
            priceLabel.text = price?.priceText
            originalPriceLabel.attributedText = price?.originalPriceText.map {
                NSAttributedString(string: $0, attributes: [NSAttributedString.Key.strikethroughStyle: NSNumber(value: 1)])
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        let size = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
        let surgingTextSize = surgeTextLabel.sizeThatFits(size)
        let costSize = priceLabel.sizeThatFits(size)
        let originalCostSize = originalPriceLabel.sizeThatFits(size)
        return CGSize(width: max(costSize.width, originalCostSize.width), height: surgingTextSize.height + costSize.height + originalCostSize.height + 2)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        build()
    }

    var body: Interface {
        ViewGroup {
            UILabel()
                .font(.preferredFont(forTextStyle: .caption1))
                .identifier("surging")
                .assign(to: \Self.surgeTextLabel, on: self)
                .translatesAutoresizingMaskIntoConstraints(false)
                .didAwakeFromBuilder { views in
                    views.this.topAnchor
                        .constraint(equalTo: views.superview.topAnchor).isActive = true

                    views.this.trailingAnchor
                        .constraint(equalTo: views.superview.trailingAnchor).isActive = true
                }

            UILabel()
                .font(.preferredFont(forTextStyle: .body))
                .textAlignment(.right)
                .textColor(.label)
                .identifier("price")
                .assign(to: \Self.priceLabel, on: self)
                .translatesAutoresizingMaskIntoConstraints(false)
                .didAwakeFromBuilder { views in
                    views.this.topAnchor.anchorWithOffset(to: views.surging.bottomAnchor)
                        .constraint(equalToConstant: 2).isActive = true

                    views.this.leadingAnchor
                        .constraint(equalTo: views.superview.leadingAnchor).isActive = true

                    views.this.trailingAnchor
                        .constraint(equalTo: views.superview.trailingAnchor).isActive = true
                }

            UILabel()
                .font(.preferredFont(forTextStyle: .caption2))
                .textColor(.tertiaryLabel)
                .assign(to: \Self.originalPriceLabel, on: self)
                .translatesAutoresizingMaskIntoConstraints(false)
                .didAwakeFromBuilder { views in
                    views.this.topAnchor.anchorWithOffset(to: views.price.bottomAnchor)
                                            .constraint(equalToConstant: 2).isActive = true
                    views.this.trailingAnchor
                        .constraint(equalTo: views.superview.trailingAnchor).isActive = true
                }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension Price: Identifiable {
// swiftlint:disable force_try
    var id: Data { try! JSONEncoder().encode(self) }
// swiftlint:enable force_try
}

// swiftlint:disable type_name
@available(iOS 13.0, *)
struct PriceView_Preview: PreviewProvider {
    static var previews: some View {
        let costs: [Price] = [
            decode(from: "normal_price"),
            decode(from: "original_price"),
            decode(from: "surge_price"),
            decode(from: "surge_original_price"),
            decode(from: "minus_surge_price"),
            decode(from: "minus_surge_original_price"),
        ].compactMap { $0 }

        return ForEach(costs, content: { (price) -> Preview in
            let priceView = PriceView()
            priceView.price = price
            return Preview(view: priceView)
        })
        .previewLayout(.sizeThatFits)
        .environment(\.colorScheme, .light)
    }
}
// swiftlint:enable type_name
#endif
