# ChowNow

## Architecture - MVVM:
Chosen: Model-View-ViewModel (MVVM)
MVVM architecture is chosen due to its clear separation of responsibilities, making the code easier to read, test, and maintain. MVVM minimizes the view/view controller's code, reducing the so-called "Massive View Controller" problem common in iOS apps. MVVM also works very well with SwiftUI and Combine, which are used in this project.

Alternatives: MVC, VIPER
Although MVC is Apple's recommended pattern, the Controller often ends up being a dumping ground for a lot of business logic and view update logic, which creates large, hard-to-maintain files. VIPER (View-Interactor-Presenter-Entity-Router) is another alternative. However, this pattern introduces more complexity than necessary for a smaller app or project, making it overkill for this particular case.

Future-thoughts: 
With more time, I would add on the coordinator pattern (MVVM+C) to separate the navigation logic and further simplify any views.

## UI - SwiftUI and UIKit:
Chosen: SwiftUI and UIKit
I leveraged both SwiftUI and UIKit. Although SwiftUI is maturing, the lack of complete control is what drove me to implement the main list view in UIKit. In a production application, where more and more features and complexity will be added to the main views, the control that UIKit offers allows for an easier time with debugging. That being said, for simpler views such as the detail view. I chose to go with SwiftUI as it allowed for faster development and easier to read views.

Alternatives: Pure UIKit, Pure SwiftUI, React Native
Pure UIKit would have the advantage of greater control over every pixel on the screen and greater maturity, but it would also lead to more verbose and complex code.

Pure SwiftUI would simplify the UI code and improve consistency across Apple platforms, but it may be harder to debug more complex views.

React Native is a cross-platform alternative, but using it would mean a loss of some of the optimization and native capabilities of SwiftUI and UIKit.

## State Management - Combine:
Chosen: Combine
Combine is a functional reactive programming framework from Apple. It's native, powerful, and designed to work seamlessly with Swift and Apple's APIs. The Combine framework is used to update the view state and cell types in response to asynchronous events and to propagate changes back to the UI.

Alternatives: NotificationCenter, Delegation, Callbacks
NotificationCenter and Delegation are traditional ways of managing state and communicating between components, but they can become complex and hard to maintain in larger projects.

Callbacks can be a simple way to handle state changes but can lead to callback hell with nested asynchronous operations.

## UI Layout - SnapKit and UICollectionViewCompositionalLayout:
Chosen: SnapKit and UICollectionViewCompositionalLayout
SnapKit is a simple DSL for AutoLayout, making the constraints more readable and easier to write. UICollectionViewCompositionalLayout is used for its flexibility and simplicity in creating complex, responsive layouts.

Alternatives: Manual Layout, UIKit's NSLayoutConstraints
Manual layout can provide more control but is more verbose, error-prone, and hard to maintain.

UIKit's NSLayoutConstraint API is the native way to handle AutoLayout but tends to be verbose.

## Networking - Protocol-based networking:
Chosen: Protocol-based networking
Creating a protocol RestaurantRepository for fetching restaurant data provides an abstraction over the actual networking code. This abstraction makes the code more testable, as you can provide mock implementations for testing purposes.

Alternatives: Direct API calls, Third-Party Libraries (Alamofire)
Direct API calls within the components would make the code harder to test and less reusable.

Third-party libraries like Alamofire can simplify networking tasks, but they add unnecessary dependencies when the task can be done natively with URLSession.

## Data Source and Cell Configuration - Diffable Data Sources:
Chosen: Diffable Data Sources
UICollectionViewDiffableDataSource simplifies the data source implementation for collection views, reduces boilerplate, and provides automatic, animating updates out of the box.

Alternatives: Traditional Data Source Methods, Third-party Libraries
Traditional UICollectionViewDataSource methods require you to manage the data source and perform manual diffing to animate changes, which can be complex and error-prone.

Third-party libraries exist to simplify this process, but they add extra dependencies to the project. Using Diffable Data Source gives similar benefits without adding external dependencies.
