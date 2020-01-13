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

IBKit lets you write intuitive UI code in a collaboration-friendly way.

Xcode storyboards and interface builders have advantages in visual representation, but have critical weaknesses:

- Readability. IB files are designed to be read by Xcode, not humans.
- Collaboration. Due to low readability, it is hard to review changes and resolve conflicts.
- Scope handling. A single storyboard file keeps growing as your codebase grows. If you don't pay enough attention, you'll find a single file contains tens of screens.
- Safety. Interface builders don't know much about your Swift code. Missing references are not caught at compile-time and lead to runtime crash.

IBKit has an intuitive syntax written in Swift code, inspired by SwiftUI, and supports easy integration with Xcode Previews.

## Requirements

* Xcode 11+
* Swift 5.1
* iOS 10

## Installation

`IBKit` requires no external dependencies. Supported installation options are:

### CocoaPods
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
> Deployment target 11.0+ is required to install IBKit via CocoaPods.

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

Declare user interfaces in `body`.

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

Instantiate your view (or view controller) using a `loadFromIB` method.

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

### Xcode Previews

1. Import the SwiftUI framework to your project. (Import **WEAKLY** if you support < iOS 13 devices, otherwise it crashes)
> Open XcodeProject > `Build Phases` > `Link Binary With Libraries` > Add `SwifTUI` > Change SwiftUI status to `Optional`

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
