//
//  Preview.swift
//  IBKit
//
//  Created by NateKim on 2019/11/11.
//
#if canImport(SwiftUI)
import SwiftUI

/// A preview that represents a UIKit view / viewController.
/// 
/// This view ignores safe area by default.
@available(iOS 13.0, *)
public struct Preview: View {

    private struct PreviewInternal: UIViewRepresentable {

        private let view: UIView
        func makeUIView(context: UIViewRepresentableContext<PreviewInternal>) -> UIView {
            return view
        }

        func updateUIView(_ view: UIView, context: UIViewRepresentableContext<PreviewInternal>) {
            view.layoutSubviews()
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
            view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }

        init(_ view: UIView) {
            self.view = view
        }
    }

    private let view: UIView

    public var body: some View {
        PreviewInternal(view).edgesIgnoringSafeArea(.all)
    }

    public init(viewController: UIViewController) {
        view = viewController.view
    }

    public init(view: UIView) {
        self.view = view
    }
}
#endif
