[![Swift version](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat.svg)](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat.svg)
[![Support Dependecy Manager](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)
[![Version](https://img.shields.io/cocoapods/v/QWarySurveySDK.svg?style=flat)](http://cocoapods.org/pods/QWarySurveySDK)
[![Platform](https://img.shields.io/cocoapods/p/QWarySurveySDK.svg?style=flat)](http://cocoapods.org/pods/QWarySurveySDK)



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

<img width="340" alt="QWSurveySDK full-screen view" src="https://i.imgur.com/MznJCGy.png">

#### Import framework
```swift
import QWarySurveySDK
```
#### Create a [`QWSurveyViewController`](#QWSurveyViewController)
Create a `QWSurveyViewController` with `QWSurveyRequest` and `QWSurveyDelegate`
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

<img width="340" alt="QWSurveySDK embed view" src="https://i.imgur.com/NK2laJU.png">

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

Override viewDidAppear method and create a `QWSurvey` object with `QWSurveyRequest`, `QWSurveyDelegate` and `QWScheduleConfigurations`. Then call `scheduleSurvey` method on the `QWSurvey` object by passing the parent `ViewController` reference to schedule the survey.
```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let qwSurvey = QWSurvey(request: request, delegate: self, configurations: QWScheduleConfigurations.default)
    qwSurvey.scheduleSurvey(parent: self)
}
```

#### Schedule Configurations
|Property|Description|
|-----------|------|
|`startDate: String`|Survey is allowed to be shown to user at this date.|
|`repeatSurvey: Bool`|After survey completion, if user should be asked for same survey again. If this property is set `true` then make sure you set a value of `repeatInterval` as well.|
|`repeatInterval: TimeInterval`|Time interval for survey to be shown to user after last attempt. This property should always have a value when `repeatSurvey` is set `true`|

#### Handle response
Implement `QWSurveyDelegate` protocol to handle responses.


## License

QWarySurveySDK is licensed under the Apache License 2.0.

For more details visit http://www.apache.org/licenses/LICENSE-2.0


## Author

**Fahid Attique** - (https://github.com/fahidattique55)

