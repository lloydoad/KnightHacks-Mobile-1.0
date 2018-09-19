# KnightHacks iOS

## Requirements

- iOS 8.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+
- Xcode 8

## Setup

## Class and File Conventions

Most of the tableview classes inherit common features from `ParentTableView` or `FilteredParentTableView`. Both of these classes can be directly inherited from and edited (or not). All cell classes are `DynamicTableViewCell`. Cells can be customized to different major types of cells by setting `cellType` variable.

#### Table View Controllers

##### ParentTableView

- Base tableview for all tables view controllers (except the `homeViewController`) in the KnightHacks app
- Handles navigation bar colors, title colors, and pushing/poping more view controllers
- Children
  - `FilteredParentTableView`
  - `FrequentlyAskedViewController`
  - `LiveUpdateViewController`

##### FilteredParentTableView
- Inherits from `ParentTableView`
- Base tableview for all table view controllers that implement a the built-in filter feature
- Handles filtering of table view controller content based on filter options and selections
- Manages setup and functioning of filters
- Children
  - `WorkshopsViewController`
  - `ScheduleViewController`
  - `SponsorsViewController`

#### Table Cell Views
