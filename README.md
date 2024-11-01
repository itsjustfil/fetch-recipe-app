### Steps to Run the App

> [!NOTE]
> Because this app was built on iOS 18.1, you must have Xcode 16.1 or later installed.
> [Download the latest version of Xcode here](https://developer.apple.com/xcode/)

1. Download the repository as a `.zip` file to a location of your choice.
2. Open the `fetch-recipe-app.xcodeproj` file to open the project in Xcode.
3. Run the app in the simulator or on a connected device.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

The areas of the project that I prioritized were the app's architecture, in this case following the Model-View-ViewModel (MVVM) architecture. A strong app architecture that is scalable and maintainable is a key to its success and improving the developer experience, as well as minimizing tech debt.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about 3 hours on this project, with most of my time allocated to building the UI, network service, and view model that drives the list of recipes. I spent the first hour or so building everything in

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

### Weakest Part of the Project: What do you think is the weakest part of your project?

I think the UI could be better, right now it's very basic and covers the bare minimum. If I spent more time on it I would've implemented a detail view for each recipe that contains a video player and the link to the source.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

No, everything used in this project is a part of Apple's iOS SDK.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I opted to make this project in the latest version of iOS, which at the time of writing is iOS 18.1. This is because I wanted to leverage the newest APIs such as Swift Testing and demonstrate its simplicity. It also provides some new SwiftUI views such as `ContentUnavailableView` which is a nice way to show empty state or error state views.
