//
//  ViewController.swift
//  IBKitExample-iOS
//
//  Created by NateKim on 2019/12/24.
//  Copyright © 2019 NateKim. All rights reserved.
//

import UIKit
import IBKit

class ViewController: UIViewController, InterfaceBuilder {

    var stackView: UIStackView!
    var estimations: [RideEstimation]? {
        didSet {
            for subview in stackView.arrangedSubviews {
                stackView.removeArrangedSubview(subview)
            }

            for e in estimations ?? [] {
                let view = RideEstimationView()
                view.estimation = e
                stackView.addArrangedSubview(view)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        build()
        estimations = decode(from: "ride_estimations")
    }

    var body: Interface {
        view.backgroundColor = .systemBackground
        return ViewGroup {
            UIStackView()
                .axis(.vertical)
                .alignment(.fill)
                .distribution(.fill)
                .spacing(0)
                .backgroundColor(.systemBackground)
                .identifier("stackview")
                .assign(to: \ViewController.stackView, on: self)
                .makeConstraints { maker, views in
                    maker.leading.trailing.equalToSuperview().inset(10)
                    maker.bottom.equalTo(views.safeAreaLayoutGuide.snp.bottom)
                    maker.height.equalTo(50).priority(.low)
                }

                UIView()
                    .backgroundColor(.separator)
                    .makeConstraints { maker, views in
                        maker.leading.trailing.equalToSuperview().inset(10)
                        maker.top.equalTo(views.stackview.snp.top)
                        maker.height.equalTo(1)
                    }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

// swiftlint:disable type_name
@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {

        let vc = ViewController()
        return Preview(viewController: vc)
            .environment(\.colorScheme, .light)
    }
}
// swiftlint:enable type_name
#endif
