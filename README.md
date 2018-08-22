# CountdownView

[![Version](https://img.shields.io/cocoapods/v/CountdownView.svg?style=flat)](https://cocoapods.org/pods/CountdownView)
[![License](https://img.shields.io/cocoapods/l/CountdownView.svg?style=flat)](https://cocoapods.org/pods/CountdownView)
[![Platform](https://img.shields.io/cocoapods/p/CountdownView.svg?style=flat)](https://cocoapods.org/pods/CountdownView)

## Usage
In order to use CountdownView simply initialise as basic version of the component as shown below:

let countdownView = CountdownView()

// Countdown until a future date
countdownView.countdown(until: futureDate)

// Countdown for a set interval with an increased interval
countdownView.countdown(for: 10000, inIntervalsOf: 0.5)

// Subscribe to all the changes 
countdownView.changeHandler = { interval in
print(interval)
}

![](https://media.giphy.com/media/93lAqclkAtskTuuP41/giphy.gif)

This will instantiate a countdown timer that will run for a duration of 10 seconds starting from the current time. The current progress can be tracked through the callback changeHandler, and any custom logic you wish to be performed based on the progess should be applied here.
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* In order to use CountdownView, a minimum iOS version of 11.0 is required.
* Swift 4.2 

## Installation

CountdownView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CountdownView'
```

## Author

Luke Sammut, sammut91@gmail.com

## License

CountdownView is available under the MIT license. See the LICENSE file for more info.

