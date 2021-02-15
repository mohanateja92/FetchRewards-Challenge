# FetchRewards-Challenge

This repository consists of iOS coding challenge from Fetch Rewards. The project is to create an iOS mobile application that fetch relevant events from SeatGeek API while user is typing in the search bar. The application should also display a Detail View when a user clicks on an event cell.

## Implementation and Design

The project is developed using iOS12, Swift5, XCode12.4 and MVC architecture. 

For displaying events data, networking is done using **URLSession** and rendered on UI. Alamofire through CocoaPods can also be used. **User Defaults** is used to save favorite events of the user. Beizer Path, IBInspectable and IBDesignable are used to draw and create a favorite button to enable favorite functionality.

SeatGeek API: https://api.seatgeek.com/2/events

## How to Install

Clone the repository using:

git clone https://github.com/mohanateja92/FetchRewards-Challenge.git

Open, build and run the file : FetchRewardsEvents.xcodeproj

## Future Scope

Infinite scrolling on table view is implemented. For efficient pagination strategy, data can be persisted in Core Data. 

NSCache with URLSession is used to retrieve the images and SDWebImage can be used through cocoapods as well.




