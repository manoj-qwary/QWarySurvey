[![Swift version](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat.svg)](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat.svg)
[![Support Dependecy Manager](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)
[![Version](https://img.shields.io/cocoapods/v/QWarySurveySDK.svg?style=flat)](http://cocoapods.org/pods/QWarySurveySDK)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/QWarySurveySDK.svg?style=flat)](http://cocoapods.org/pods/QWarySurveySDK)
[![CocoaPods](https://img.shields.io/cocoapods/dt/QWarySurveySDK.svg)](http://cocoapods.org/pods/QWarySurveySDK)
[![CocoaPods](https://img.shields.io/cocoapods/at/QWarySurveySDK.svg)](http://cocoapods.org/pods/QWarySurveySDK)



## Description
---

QWarySurvey iOS SDK enables you to collect feedback from your mobile app. Embed the surveys in your iOS application seamlessly with few lines of code.

## Features
1. [Full screen feedback](#Full-screen-feedback)
2. [Embedded-screen feedback](#Embed-survey)
3. [Scheduled Surveys one-time or recurring feedbacks.](#Schedule-Surveys)


## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```


To integrate QWarySurveySDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod 'QWarySurveySDK'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Full-screen feedback
Take feedback using our pre-build `QWSurveyViewController` and get the response after submission by implementing the `QWSurveyDelegate` protocol.

<img width="340" alt="SurveySparrow Android SDK full-screen view" src="https://user-images.githubusercontent.com/61273614/85126008-37b2a500-b24a-11ea-8b7d-1edd55ecc668.png">

#### Import framework
```swift
import QWarySurveySDK
```
#### Create a [`QWSurveyViewController`](#QWSurveyViewController)
Create a `QWSurveyViewController` with  `QWSurveyRequest` and `QWSurveyDelegate`
```swift
var urlQueryParams = [String:String]()
urlQueryParams["email"] = "jondoe2@acmeinc.com"
urlQueryParams["planId"] = "trial2"
let request = QWSurveyRequest(scheme: "https", host: "survey.qwary.com", path: "/form/S_wSzSPnasH9Wc_FT15X0J1BuEcPl5gIZ99rQiotQa8=", params: urlQueryParams)
let qwSurveyViewController = QWSurveyViewController(request: request, delegate: self)
present(qwSurveyViewController, animated: true, completion: nil)
```

### Embed survey 
Embed the feedback experience using the [`QWSurveyView`](#QWSurveyView).

<img width="340" alt="SurveySparrow Android SDK embed view" src="https://user-images.githubusercontent.com/61273614/85125981-2e293d00-b24a-11ea-8468-d56f1035dccb.png">

#### Add QWSurveyView
Add a `UIView` to storyboard and change the Class to `QWSurveyView` under *Identity Inspector* and also make sure that the Module is `QWarySurveySDK`.

Now connect the `QWSurveyView` as an `IBOutlet`
```swift
@IBOutlet weak var qwSurveyView: QWSurveyView!
```
Then call `loadSurvey(request: QWSurveyRequest, delegate: QWSurveyDelegate?)` on the `qwSurveyView` to load the survey
```swift
let request = QWSurveyRequest(scheme: "https", host: "survey.qwary.com", path: "/form/S_wSzSPnasH9Wc_FT15X0J1BuEcPl5gIZ99rQiotQa8=", params: [String:String]())
qwSurveyView.loadSurvey(request: request, delegate: self)
```
#### Handle response
Implement `QWSurveyDelegate` protocol to handle responses.

### Schedule Surveys
Ask the user to take a feedback survey when they open your app or a screen after specified time.

<img width="340" alt="SurveySparrow Android SDK scheduling" src="https://user-images.githubusercontent.com/61273614/85126016-3d0fef80-b24a-11ea-8760-89bf3cca8af4.png">


Override viewDidAppear method and create a `QWSurvey` object by passing domain and `token`. Then call `scheduleSurvey` method on the `QWSurvey` object by passing the parent `ViewController` reference to schedule the survey.
```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let qwSurvey = QWSurvey(request: request, delegate: self)
    qwSurvey.scheduleSurvey(parent: self)
}
```

#### Handle response
Implement `QWSurveyDelegate` protocol to handle responses.
## License

QWarySurveySDK is licensed under the Apache License 2.0.

For more details visit http://www.apache.org/licenses/LICENSE-2.0


## Author

**Fahid Attique** - (https://github.com/fahidattique55)

