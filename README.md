<p align="center">
  <img alt="Swift" src="https://img.shields.io/badge/Swift-5.1-orange.svg">
  <img alt="CocoaPods" src="http://img.shields.io/cocoapods/v/IBKit.svg">
  <a href="https://github.com/IBCodeKit/IBKit" target="_blank">
    <img alt="Platform" src="https://img.shields.io/cocoapods/p/IBKit.svg?style=flat">
  </a>
  <a href="https://travis-ci.org/IBCodeKit/IBKit" target="_blank">
    <img alt="Build Status" src="https://travis-ci.org/IBCodeKit/IBKit.svg?branch=master">
  </a>
</p>

# IBKit

A declarative style interface builder in Swift.

```Swift
var body: Interface {
  ViewGroup {
    UIImageView()
      .assign(to: \Self.thumbnailImageView, on: self)

    UIView {
      UILabel()
        .font(.preferredFont(forTextStyle: .title2))
        .textColor(.label)

      UILabel()
        .font(.preferredFont(forTextStyle: .caption1))
        .textColor(.secondaryLabel)
        .assign(to: \Self.additionalTextLabel, on: self)

      UIImageView()
        .image(UIImage(named: "ic_passenger")?.withRenderingMode(.alwaysTemplate))
        .tintColor(.secondaryLabel)

      UILabel()
        .font(.preferredFont(forTextStyle: .caption1))
        .textColor(.secondaryLabel)
    }
    .backgroundColor(.systemBackground)

    PriceView()

    UIView()
      .backgroundColor(.separator)
  }
}
```

## Why IBKit

Storyboard, XIB is a kind of XML file. However have you ever edited a storyboard or XIB by hand? Probably not. It isn't easy to read or edit. Storyboards and XIBs have many troublesome properties such as `id`, `destination`, etc. Futhermore these contain a fairly large amount of XML. So it is impossible to see what’s changed when someone opens a pull request with its modification.

Worse, Storyboards have a habit of growing larger and larger over time. they might start off small, but then you add another view controller and another, and another, and suddenly you realize that you have ten screens of data in a single file, and any source control changes you make are suddenly quite painful.

Also, Interface Builder doesn’t know much about the Swift code, and vice versa. It makes you have lots of unsafe functionality. For example, we Ctrl-drag from IB into our code to connect something to an action. Then what if we delete that action on the code? The code still compiles well but it will be crashed!

~Finally Interface Builder doesn't work as intended. Named colors that set from xib can not be changed in `viewDidLoad`, `viewWillAppear`, `awakeFromNib` method.~

Nevertheless, Storyboard, XIB has powerful advantages. It gives you a very good visual representation. Also it is easy of use. When you create a ViewController programmatically, it has a lot of codes and looks too verbose.

Basically, IBKit is a tool for programmtically UI. By using declarative style, you can understand the UI intuitively. Also IBKit has a simple `Preview` class for Xcode Previews. You can be given a realtime visual representation easily.

IBKit is the most straight forward, the easiest way to implement your UI.

## Requirements

* Xcode 11+
* Swift 5.1
* iOS 10

## Installation

`IBKit` doesn't contain any external dependencies.
These are currently support options:

### Cocoapods
```
# Podfile
user_framework!
target 'YOUR_TARGET_NAME' do
    pod 'IBKit'
end
```
Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:
```
$ pod install
```
> Deployment target 11.0+ is required to install IBKit via Cocoapods.

### Swift Package Manager

Create a `Package.swift` file.
```Swift
// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "NAME",
  dependencies: [
    .package(url: "https://github.com/IBCodeKit/IBKit.git", from: "SEMVER_TAG")
  ],
  targets: [
    .target(name: "NAME", dependencies: ["IBKit"])
  ]
)
```
Replace `SEMVER_TAG` and then type:
```
$ swift build
```

Or 

Open XcodeProject > `File` > `Swift Packages` > `Add Package Dependency..`

Then, Type `https://github.com/IBCodeKit/IBKit.git`

## Usage

Conform to `InterfaceBuilder` protocol.

```Swift
class PriceView: UIView, InterfaceBuilder {
  var body: Interface {
    ...
  }
}
```

Declare user interfaces in the body

```Swift
ViewGroup {
  UIImageView()
    .assign(to: \Self.thumbnailImageView, on: self)

  UIView {
    UILabel()
      .font(.preferredFont(forTextStyle: .title2))
      .textColor(.label)

    UILabel()
      .font(.preferredFont(forTextStyle: .caption1))
      .textColor(.secondaryLabel)
      .didAwakeFromBuilder { views in
        views.this.topAnchor.constraint(equalTo: views.superview.topAnchor).isActive = true
        views.this.trailingAnchor.constraint(equalTo: views.superview.trailingAnchor).isActive = true
      }
  }
  .backgroundColor(.systemBackground)
}
```

Instantiate your view(Controller) using a `loadFromIB` method.

```Swift
let view = PriceView.loadFromIB()
```

Or load the body using a `build` method.

```Swift
override init(frame: CGRect) {
  super.init(frame: frame)
  build()
}
```

### Xcode Preivews

1. To use Xcode Previews, SwiftUI framework must be imported weakly on your project.

    Open XcodeProject > `Build Phases` > `Link Binary With Libraries` > Add `SwifTUI` > Change SwiftUI status to `Optional`

2. Conform to `PreviewProvider` protocol.

```Swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct PriceView_Preview: PreviewProvider {
  ...
}
#endif
```

3. Implement `PreviewProvider` protocol with `Preview` class.

```Swift
static var previews: some View {
  Preview(view: PriceView.loadFromIB())
}
```

## Contribution
Any pull requests and bug reports are welcome!

Feel free to make a pull request.