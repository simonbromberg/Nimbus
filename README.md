# Nimbus
Simple weather app using SwiftUI, Swift Concurrency, and the [Metaweather](https://www.metaweather.com/) API].

## Components

### NimbusApp
SwiftUI entry point for the app controlling what UI is shown.

### WeatherView
Main UI screen of the app for displaying information about the current weather for a location.

### NetworkProvider
Connects to the Metaweather API to fetch weather for a given locaiton. Abstracted so that it can be mocked in tests.

### NimbusTests
Some simple unit tests 
