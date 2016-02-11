![Language](https://img.shields.io/badge/language-Swift%202%2B-orange.svg)
[![Xcode](https://img.shields.io/badge/Xcode-7.0%2B-brightgreen.svg?style=flat)]()
[![iOS](https://img.shields.io/badge/iOS-8.0%2B-brightgreen.svg?style=flat)]()
[![Build Status](https://travis-ci.org/sgr-ksmt/EnhancedAutoReleasePool.svg?branch=master)](https://travis-ci.org/sgr-ksmt/EnhancedAutoReleasePool)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](https://img.shields.io/cocoapods/v/EnhancedAutoReleasePool.svg?style=flat)](http://cocoapods.org/pods/EnhancedAutoReleasePool)

# EnhancedAutoReleasePool

EnhancedAutoReleasePool is μ-Library for autoreleasepool.    
This library is useful for :
- `do〜try〜catch`
- Returning value from autoreleasepool().

## Functions

```swift
public func autoreleasepool(@noescape code: () throws -> ()) rethrows
public func autoreleasepool<V>(@noescape code: () throws -> V?) rethrows -> V?
public func autoreleasepool<V>(@noescape code: () throws -> V) rethrows -> V
```

## Usage

```swift
// MARK: normal autoreleasepool
(0..<10000).forEach { _ in
    autoreleasepool {
        let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
        imgView.image = mockImage()
        imgView.image = nil
    }
}
XCTAssertEqual(arr1.count, 10000)

// MARK: autorelease and return value
var arr2 = [Int]()
(0..<10000).forEach { _ in
    let value = autoreleasepool { () -> Int in
        let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
        imgView.image = mockImage()
        imgView.image = nil
        return 1
    }
    arr2.append(value)
}
print(arr2.count)

// MARK: autorelease and return value?
var arr3 = [Int?]()
(0..<10000).forEach { index in
    let value = autoreleasepool { () -> Int? in
        let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
        imgView.image = mockImage()
        imgView.image = nil
        return (index % 2 == 0 ? nil : 1)
    }
    arr3.append(value)
}
print(arr3.count)

// MARK: autorelease with try
var arr4 = [Int]()
do {
    try (0..<10000).forEach { index in
        try autoreleasepool {
            if (index == 5000) {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
            imgView.image = mockImage()
            arr4.append(1)
            imgView.image = nil
        }
    }
} catch ( _) {

}
print(arr4.count)
```

## Requirements
- iOS 8.0+
- Xcode 7.0+(Swift 2+)

## Installation

### Carthage

- Add the following to your *Cartfile*:

```bash
github 'sgr-ksmt/EnhancedAutoReleasePool'
```

- Run `carthage update`
- Add the framework as described.
<br> Details: [Carthage Readme](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)


### CocoaPods

**EnhancedAutoReleasePool** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EnhancedAutoReleasePool'
```

and run `pod install`


## Communication
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request.:muscle:

## License

**EnhancedAutoReleasePool** is under MIT license. See the [LICENSE](LICENSE) file for more info.