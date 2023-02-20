# Weather

Weather app using SwiftUI and Combine

## Usage

* Run the project on a simulator or a device
* Grant the location permission
* The weather will be displayed
* Switch scale

## Focus
* MVVM architecture
* Project hierarchy
* Dependency injection
* Unit testing

## Missed
* More impressive UI
* UI tests
* Handling missing connectivity
* Handling location permissions not granted or revoked

### Notes
[Tomorrow.io](https://www.tomorrow.io/) was used as a weather service because it supports HTTPS. 
The service response fails when calling it many times within a small time frame due to the limitation of the free subscription.
I had to create a simulation mode and added it to the main screen. It was intergrated in the view model.
It generates a random temperature in case the service response fails.

