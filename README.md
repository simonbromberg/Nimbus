# Nimbus
Simple weather app using SwiftUI, Swift Concurrency, and the [Metaweather](https://www.metaweather.com/) API.

## How to run

This project was built with Swift 5.5, Xcode 13.2.1 on macOS 11.6.4, but it should be compatible with newer versions.

To run the app, select a simulator and open the xcodeproj file in Xcode and click Product > Run.

Toggle light/dark mode on the simulator with Features > Toggle Appearance.

## Components

### NimbusApp
SwiftUI entry point for the app controlling what UI is shown.

### ContentView
A wrapper for the main UI view that manages loading, reloading, and displaying errors. The weather is sent along to the `WeatherView` via a `Binding`, so when the `weather` property is updated, the `WeatherView` instance is automatically updated too.

The use of a placeholder `Weather` instance helps keep things simple; in a production application the loading, reloading UI would be more elaborate. The addition of a simple reload button makes the app easier to test.

### WeatherView
Core UI of the app which displays information about the current weather for a location. This view is neatly abstracted from the networking which helps with maintainability and collaboration.

The icons used for the weather are downloaded from Metaweather, which ensures consistency between the images and the data. In case the API sends an unknown weather state abbreviation, the app will show a placeholder system image. The app still uses on the state name from the API, since you'd still want to display that even if the image was not available.   

### DataProvider
A protocol interface for getting weather data. `NetworkProvider` implements it using the Metaweather API, and `MockProvider` uses a local fixture json file as specified by a filename. The latter makes it simple to do unit tests or if you're debugging the app, you can easily swap out the data provider passed to `ContentView`. 

`DataProvider` uses its own internal models for decoding JSON data. One could decode the JSON data directly into the `Weather` view model using `CodingKeys` to keep the property names clean, but this approach is more flexible and modular. 

### NimbusTests
A few unit tests that use `MockProvider` to load well-formed and malformed data from local JSON files and check if they match what is expected and throw the expected errors. This uses a *copied snippet from a WWT post* to enable `XCTAssertThrows` on async methods.

## General Trade-offs
SwiftUI can facilitate the quick development of clean, maintanable code, plus I find it to be an interesting challenge. But not all developers are as familiar with SwiftUI yet. SwiftUI also still changes significantly between iOS versions, so it's not a great choice if you need to support old versions of iOS.

Swift Concurrency helps produce really concise networking code, but again it's newer and not as well-known. However, it has backwards compatibility, meaning it isn't as complicated to support iOS 13 at least.

I downloaded the image files from Metaweather, which reduces complexity and network load, but it does mean that the app would need to be updated if new weather states are added (or the icons are edited). Hopefully that won't happen anytime soon.

## Additional Information

I adapted some aspects of `DataProvider` from a similar app I have created recently, though I have expanded upon those ideas here and modified them to suit this project.
