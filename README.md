# KnightHacks iOS

## Requirements

- iOS 10.0+
- Xcode 9

## Setup
- Download or clone repo
- Install cocoapods
"
```sudo gem install cocoapods```
"
- Setup Pods at root
"
```pod setup verbose```
"
- Install Pods included in repo at repo root
"
```pod install```
"

## Class Conventions and Usage

Most of the tableview classes inherit common features from `ParentTableView` or `FilteredParentTableView`. Both of these classes can be directly inherited from and edited (or not). All cell classes are `DynamicTableViewCell`. Cells can be customized to different major types of cells by setting `cellType` variable.

#### Table View Controllers

##### ParentTableView

- Inherits from `UITableViewController`
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

#### Table View Controller Cells

##### DynamicTableViewCell
- Inherits from `UITableViewCell`
- Base table view cell used to construct all cells in KnightHacks application
- Has dynamic height to fit text content
- Manages all included cell types with the exception of specialized cells i.e. `LiveUpdateTableViewCell` and `FilterMenuButtonCollectionViewCell`
- Has interchangeable components
- Manages reloading of changed cells
- Children 
  - `DefaultDynamicTableViewCell`
  - `LeftImageDynamicTableViewCell`
  - `DetailedDynamicTableViewCell`
  - `HiddenDetailDynamicTableViewCell`
  
###### Usage
- Initialization
```swift 
tableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: DynamicTableViewCell.identifier)

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
      cell.cellType = FormattedTableViewCellType
      return cell
}
```

OR 

``` swift 
tableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: DynamicTableViewCell.identifier)

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = DynamicTableViewCell(style: UITableViewCellStyle, reuseIdentifier: DynamicTableViewCell.identifier) as! DynamicTableViewCell
      cell.cellType = FormattedTableViewCellType
      return cell
}
```
- Changing Internal Components
```swift 
// margins, borders and sizes
override var xMargin: CGFloat { get }
override var yMargin: CGFloat { get }
override var backgroundInnerMargin: CGFloat { get }

// images in cell
override var imageSideLength: CGFloat { get }
override var largeImageSideLength: CGFloat { get }
```

- Accessing Available Components
```swift 
var backgroundViewWithShadow: UIView? { set }
var titleLabel: UILabel? { set }
var locationLabel: UILabel? { set }
var timeLabel: UILabel? { set }
var contentImageView: UIImageView? { set }
var itemDescriptionLabel: UILabel? { set }
var itemTagLabel: UILabel? { set }
var horizontalTagStack: UIStackView? { set }
var showMoreButton: UIButton? { set }
```

- Changing Overall Cell Appearance
  - **NOTE** Some of these changes are only available within specific cell types
``` swift 
var cellType: FormattedTableViewCellType { get, set }
var hasUpperTags: Bool = false { get, set }
var hasRegularRightDetail: Bool { get, set }
var hasStyledTags: Bool { get, set }
var isShowingDetails: Bool { get, set }
```
  
