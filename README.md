# VenueFinder

VenueFinder is an app to find venues of any kind near you or a specified location. Users can search venue names and keywords to narrow down results. 

**Location Prompt** | **Location Disabled** | **Search by current location** | **Search by location keyword** | **View Venue Details** |
:---: | :---: | :---: | :---: | :---: |
![image](https://user-images.githubusercontent.com/62037569/102729340-5f202280-42fe-11eb-9d6e-28b245101625.png) | ![image](https://user-images.githubusercontent.com/62037569/102729361-78c16a00-42fe-11eb-9fe1-8024d7449362.png) | ![image](https://user-images.githubusercontent.com/62037569/102729348-6b0be480-42fe-11eb-9703-bfc024a7e10a.png) | ![image](https://user-images.githubusercontent.com/62037569/102729350-70692f00-42fe-11eb-8428-710e7314b127.png) | ![image](https://user-images.githubusercontent.com/62037569/102729366-7ced8780-42fe-11eb-8b15-c7cb2d7b42fc.png) |


## Features

- [x] Search for venues near your current physical location
- [x] Search for venues by providing a location keyword (a city, state, etc.)
- [x] Narrow down results by providing a query to search against venues with
- [x] View details of a venue
- [x] Access contact and social media links for a venue 

### Feature Requirements:
- [x] **Networking code. Your app should NOT use the native foursquare iOS SDK, but rather hit their public restful API.**
> App contains services hitting Foursquare's Places API
- [x] **Geolocation of user**
  - [x] **A way to select geolocation as an option (a button maybe)**
  - [x] **should also handle when geolocation is off or not enabled yet**
> User can search their location via the location button in the nav bar. Used CoreLocation manager to handle user's location permissions.
- [x] **Search by query**
  - [x] **should allow users to search based on a query rather than their current location**
> Users can search a combination of location query + venue query.
- [x] **A list of results from foursquare with all the information you believe a user needs to see**
  - [x] **With an icon & distance**
> List view displays a photo of the venue, the venue name, the venue address (if available), and the distance (if available and user searched via their location).
- [x] **A detail view for a venue with extended details that you think are important (like venue photo, etc)**
> Detail view displays a larger venue photo, name, address, phone number, website, and social media links (where available).
- [x] **Some nice transitions to and from list views to details**
> There is a subtle fade animation as user navigates between Venue List and Details views.
- [x] Add your own personal UI flare
> App contains some styling and custom views.
- [ ] **Handle pagination**
> App does **not** handle pagination... I couldn't figure out how to emulate pagination without `limit` and `offset` query parameters :( 
- [x] **Finally, please comment your code including notes on design decisions.**
> Comments on some design decisions (namely services singleton and delegate pattern) in code

## Requirements

- iOS 13.1+
- Xcode 11.0+

## Installation

#### CocoaPods
Install Cocoapods
`$ sudo gem install cocoapods`

You can use [CocoaPods](http://cocoapods.org/) to install required pods by adding them to your `Podfile`:

```ruby
target 'VenueFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VenueFinder

	pod 'SDWebImage'

end
```
 
