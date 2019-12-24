import XCTest
import UIKit
@testable import IBKit

final class Tests: XCTestCase {
    class NestedView: UIView, InterfaceBuilder {
        var body: Interface {
            ViewGroup {
                UIView {
                    UIView()
                        .identifier("divider")

                    UILabel()
                        .identifier("test_label")

                }
                .identifier("container")

                UIButton()
                    .identifier("test_button")
            }
        }
    }

    class TestViewController: UIViewController, InterfaceBuilder {
        var body: Interface {
            ViewGroup {
                UIView {
                    UIView()
                        .identifier("divider")

                }
                .identifier("test_container")

                NestedView.loadFromIB()
                    .identifier("nested_view")
            }
        }
    }

    class TestView: UIView, InterfaceBuilder {
        var body: Interface {
            ViewGroup {
                UIView {
                    UIView()
                        .identifier("divider")

                }
                .identifier("test_container")

                NestedView.loadFromIB()
                    .identifier("nested_view")
            }
        }
    }

    func testIdentifier() {
        let view = UIView().identifier("identifier")

        XCTAssert(view.identifier == "identifier", "Should have identifier.")
    }

    func testFlushNestedIdentifiersOnView() {
        let view = TestView.loadFromIB()
        let nestedView = view.subviews.last as? NestedView

        XCTAssertNotNil(view.subviews.first)
        XCTAssertNotNil(nestedView)
        XCTAssertNil(view.subviews.first?.identifier, "Interface builder should flush identifiers having loaded the view.")
        XCTAssertNil(nestedView?.identifier, "Interface builder should flush identifiers having loaded the view.")
        XCTAssertNil(nestedView?.subviews.first?.identifier, "Interface builder should flush identifiers having loaded the view.")
    }

    func testFlushNestedIdentifiersOnViewController() {
        let vc = TestViewController.loadFromIB()
        let nestedView = vc.view.subviews.last as? NestedView

        XCTAssertNotNil(vc.view.subviews.first)
        XCTAssertNotNil(nestedView)
        XCTAssertNil(vc.view.subviews.first?.identifier, "Interface builder should flush identifiers having loaded the view.")
        XCTAssertNil(nestedView?.identifier, "Interface builder should flush identifiers having loaded the view.")
        XCTAssertNil(nestedView?.subviews.first?.identifier, "Interface builder should flush identifiers having loaded the view.")
    }

    func testBuildOnView() {
        let view = TestView()

        XCTAssertEqual(view.subviews.count, 0, "TestView should not have any subviews.")
        view.build()

        XCTAssertEqual(view.subviews.count, 2, "TestView should have 2 subviews.")
        XCTAssertEqual(view.subviews.first?.subviews.count, 1, "TestView's first subview should have a subview.")
        XCTAssert(view.subviews.last is NestedView, "TestView's last subview must be NestedView.")
    }

    func testBuildOnViewController(){
        let vc = TestViewController()

        XCTAssertEqual(vc.view.subviews.count, 0, "TestViewController should not have any subviews.")
        vc.build()

        XCTAssertEqual(vc.view.subviews.count, 2, "TestViewController should have 2 subviews.")
        XCTAssertEqual(vc.view.subviews.first?.subviews.count, 1, "TestViewController's first subview should have a subview.")
        XCTAssert(vc.view.subviews.last is NestedView, "TestViewController's last subview must be NestedView.")
    }

    func testLoadView() {
        let view = TestView.loadFromIB()

        XCTAssertEqual(view.subviews.count, 2, "TestView should have 2 subviews.")
        XCTAssertEqual(view.subviews.first?.subviews.count, 1, "TestView's first subview should have a subview.")
        XCTAssert(view.subviews.last is NestedView, "TestView's last subview must be NestedView.")
    }

    func testLoadViewController() {
        let vc = TestViewController.loadFromIB()

        XCTAssertEqual(vc.view.subviews.count, 2, "TestViewController should have 2 subviews.")
        XCTAssertEqual(vc.view.subviews.first?.subviews.count, 1, "TestViewController's first subview should have a subview.")
        XCTAssert(vc.view.subviews.last is NestedView, "TestViewController's last subview must be NestedView.")
    }

    static var allTests = [
        ("testIdentifier", testIdentifier),
        ("testFlushNestedIdentifiersOnView", testFlushNestedIdentifiersOnView),
        ("testFlushNestedIdentifiersOnViewController", testFlushNestedIdentifiersOnViewController),
        ("testBuildOnView", testBuildOnView),
        ("testBuildOnViewController", testBuildOnViewController),
        ("testLoadViewController", testLoadViewController),
        ("testLoadView", testLoadView),
    ]
}
