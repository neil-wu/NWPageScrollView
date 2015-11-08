# NWPageScrollView

## Introduce
NWPageScrollView is designed to simplify the implementation of horizontal, paged scrolling views on iOS. Take a look at the following example:

![Other Linker Flags](https://github.com/neil-wu/neil-wu.github.io/blob/master/images/article/NWPageScrollViewDemo/demo.gif)

As we know, `UIScrollView` has a property `pagingEnabled`. It is a Boolean value that determines whether paging is enabled for the scroll view. If the value of this property is true, the scroll view stops on multiples of the scroll view’s bounds when the user scrolls. The default value is false.

NWPageScrollView is based on this trick.


## Installation
Just add `NWPageScrollView.swift` into your swift project.

## Requirements
* iOS 7.0+ / Mac OS X 10.10+
* Xcode 7.0
* Swift 2.0

## Usage
The interface is UITableView-style. It's easy to use. Just open the demo project and run it.

Using like this:

```swift
topPageScrollView = NWPageScrollView()
topPageScrollView.pageScrollDelegate = self
topPageScrollView.initSetup(maxSize, cellSize: cellSize, padding: 0)
self.addSubview(topPageScrollView)

topPageScrollView.reloadData()
```
Do not forget to implement the `NWPageScrollViewDelegate`



## License
MIT License, Please feel free to use it.


