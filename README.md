# UIListExample

## What this repo is for

The purpose of this repo is to demonstrate the new apis for integrating a UITableView (or UICollectionView with some minor alterations) in a SwiftUI app.  Specifically, in the situation that the default List or LazyVStack implementations can not cover.  As an example, prefetching items in a list is not supported in SwiftUI, but we can make a wrapper for their UIKit counterparts to create a list that can prefetch items.  Note, this will only work on iOS 16 due to the new addition of ```contentConfiguration``` on UITableView and UICollectionView cells.

## Navigating this repo

In this repo you'll find a simple wrapper around UITableView utilizing ```DiffableDataSource``` and prefetching.  In the ```FizzBuzzContent``` you'll see how to utilize the wrapped view.  The app itself is a simple FizzBuzz app that shows a single detail screen.
