# KnightHacks iOS

## Requirements

- iOS 8.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+
- Xcode 8

## Setup

## Class Conventions and Usage

Most of the tableview classes inherit common features from `ParentTableView` or `FilteredParentTableView`. Both of these classes can be directly inherited from and edited (or not). All cell classes are `DynamicTableViewCell`. Cells can be customized to different major types of cells by setting `cellType` variable.

#### Table View Controllers

##### ParentTableView

- Base tableview for all tables view controllers (except the `homeViewController`) in the KnightHacks app
- Handles navigation bar colors, title colors, and pushing/poping more view controllers
- Children
  - `FilteredParentTableView`
  - `FrequentlyAskedViewController`
  - `LiveUpdateViewController`
  
###### Usage
- Initialization
```swift 
let view = ParentTableView()
```

##### FilteredParentTableView
- Inherits from `ParentTableView`
- Base tableview for all table view controllers that implement a the built-in filter feature
- Handles filtering of table view controller content based on filter options and selections
- Manages setup and functioning of filters
- Children
  - `WorkshopsViewController`
  - `ScheduleViewController`
  - `SponsorsViewController`

###### Usage
- Initialization
```swift 
let viewController = FilteredParentTableView(style: UITableViewStyle, filterOptions: [FilterButton], content: [(String,[Int])])
```
- Changing View Features
```swift 
var isBarAnimationComplete: Bool { get, set }
var hasHeaders: Bool { get, set }

var headerRowHeight: CGFloat { get, set }
var filterOptions: [FilterButton] { get, set }
var tableDataContent: [(String,[Int])] { get, set }
```

#### Table Cell Views
