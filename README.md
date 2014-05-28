# GSIndeterminateProgressBar

[![Version](https://img.shields.io/cocoapods/v/GSIndeterminateProgressBar.svg?style=flat)](http://cocoadocs.org/docsets/GSIndeterminateProgressBar)
[![License](https://img.shields.io/cocoapods/l/GSIndeterminateProgressBar.svg?style=flat)](http://cocoadocs.org/docsets/GSIndeterminateProgressBar)
[![Platform](https://img.shields.io/cocoapods/p/GSIndeterminateProgressBar.svg?style=flat)](http://cocoadocs.org/docsets/GSIndeterminateProgressBar)

**GSIndeterminateProgressView** is a subclass of **UIView** that looks like
**UIProgressView** but acts like **UIActivityIndicatorView**.

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

![Capture](/capture.gif?raw=true "Capture in action")

Import **GSIndeterminateProgressView.h**

```objective-c
    UINavigationBar *navigationBar = self.navigationController.navigationBar;

    GSIndeterminateProgressView *progressView = [[GSIndeterminateProgressView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height - 2,
                                                                                                              navigationBar.frame.size.width, 2)];
    progressView.progressTintColor = navigationBar.barTintColor;
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [navigationBar addSubview:progressView];

    [progressView startAnimating];
```

## Installation

GSIndeterminateProgressBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "GSIndeterminateProgressBar"

## Author

Endika Gutiérrez, me@endika.net

## License

GSIndeterminateProgressBar is available under the MIT license. See the LICENSE file for more info.

