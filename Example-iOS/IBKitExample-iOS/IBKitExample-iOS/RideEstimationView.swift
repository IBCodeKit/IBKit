//
//  RideEstimationView.swift
//  IBKitExample-iOS
//
//  Created by NateKim on 2019/12/24.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit
import IBKit
import SnapKit

class RideEstimationView: UIView, InterfaceBuilder {

    var thumbnailImageView: UIImageView!
    var nameLabel: UILabel!
    var additionalTextLabel: UILabel!
    var iconLeadingConstraint: SnapKit.Constraint!
    var passengerLabel: UILabel!
    var priceView: PriceView!

    var estimation: RideEstimation? {
        didSet {
            nameLabel.text = estimation?.type.name
            thumbnailImageView.image = UIImage(named: estimation?.type.image ?? "")
            additionalTextLabel.text = estimation?.type.additionalText
            passengerLabel.text = estimation?.type.passengers
            priceView.price = estimation?.price
            iconLeadingConstraint?.update(offset: estimation?.type.additionalText != nil ? 6 : 0)
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 500, height: 90)
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
            UIView()
                .also {
                    let gradient = CAGradientLayer()
                    gradient.type = .radial
                    gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
                    gradient.endPoint = CGPoint(x: 1, y: 1)
                    gradient.colors = [UIColor.tertiarySystemBackground.cgColor, UIColor.clear.cgColor]
                    gradient.frame = CGRect(origin: .zero, size: CGSize(width: 99, height: 83))
                    $0.layer.addSublayer(gradient)
                }
                .identifier("thumbnailBg")
                .makeConstraints { (maker, _) in
                    maker.width.equalTo(90)
                    maker.height.equalTo(73)
                    maker.leading.equalToSuperview().offset(-10)
                    maker.centerY.equalToSuperview()
                }

            UIImageView()
                .identifier("thumbnail")
                .assign(to: \Self.thumbnailImageView, on: self)
                .makeConstraints { (maker, views) in
                    maker.centerY.equalToSuperview()
                    maker.centerX.equalTo(views.thumbnailBg.snp.centerX).offset(5)
                    maker.width.equalTo(79)
                    maker.height.equalTo(53)
                }

            UIView {
                UILabel()
                    .font(.preferredFont(forTextStyle: .title2))
                    .textColor(.label)
                    .identifier("rideName")
                    .assign(to: \Self.nameLabel, on: self)
                    .makeConstraints { (maker, _) in
                        maker.top.leading.equalToSuperview()
                        maker.trailing.lessThanOrEqualToSuperview()
                    }

                UILabel()
                    .font(.preferredFont(forTextStyle: .caption1))
                    .textColor(.secondaryLabel)
                    .identifier("additionalText")
                    .assign(to: \Self.additionalTextLabel, on: self)
                    .makeConstraints { (maker, views) in
                        maker.top.equalTo(views.rideName.snp.bottom).offset(2)
                        maker.bottom.equalToSuperview()
                        maker.leading.equalToSuperview()
                    }

                UIImageView()
                    .image(UIImage(named: "ic_passenger")?.withRenderingMode(.alwaysTemplate))
                    .tintColor(.secondaryLabel)
                    .identifier("icon")
                    .makeConstraints { (maker, views) in
                        self.iconLeadingConstraint = maker.leading.equalTo(views.additionalText.snp.trailing).offset(6).constraint
                        maker.centerY.equalTo(views.additionalText.snp.centerY)
                        maker.width.height.equalTo(10)
                    }

                UILabel()
                    .font(.preferredFont(forTextStyle: .caption1))
                    .textColor(.secondaryLabel)
                    .assign(to: \Self.passengerLabel, on: self)
                    .makeConstraints { (maker, views) in
                        maker.centerY.equalTo(views.additionalText.snp.centerY)
                        maker.bottom.equalToSuperview()
                        maker.leading.equalTo(views.icon.snp.trailing).offset(4)
                        maker.trailing.lessThanOrEqualToSuperview()
                    }
            }
            .identifier("container")
            .makeConstraints { (maker, views) in
                maker.centerY.equalToSuperview()
                maker.leading.equalTo(views.thumbnail.snp.trailing).offset(8)
                maker.width.equalTo(50).priority(.low)
            }

            PriceView.loadFromIB()
                .assign(to: \Self.priceView, on: self)
                .makeConstraints { (maker, views) in
                    maker.trailing.centerY.equalToSuperview()
                    maker.leading.greaterThanOrEqualTo(views.container.snp.trailing)
                }

            UIView()
                .backgroundColor(.separator)
                .makeConstraints { (maker, _) in
                    maker.leading.trailing.bottom.equalToSuperview()
                    maker.height.equalTo(1)
                }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension RideEstimation: Identifiable {
// swiftlint:disable force_try
    var id: Data { try! JSONEncoder().encode(self) }
// swiftlint:enable force_try
}

// swiftlint:disable type_name
@available(iOS 13.0, *)
struct RideItemView_Preview: PreviewProvider {
    static var previews: some View {
        let estimations: [RideEstimation] = decode(from: "ride_estimations") ?? []

        return ForEach(estimations, content: { (estimation) -> Preview in
            let view = RideEstimationView()
            view.estimation = estimation
            return Preview(view: view)
        })
        .previewLayout(.sizeThatFits)
        .environment(\.colorScheme, .light)
    }
}
// swiftlint:enable type_name
#endif
