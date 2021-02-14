<!-- HEADER -->
<img src="./Images/petulia-icon-128.png" width="60" align="right"/>
<h1>Petulia - Pet Adoption iOS App</h1>

<!-- PROJECT SHIELDS -->
<p align="left">
<a href="https://twitter.com/EsMoscu">
<img src="https://img.shields.io/badge/-Twitter-%231DA1F2" alt="Twitter" /></a> 
<a href="https://www.instagram.com/ispanskiy/">
<img src="https://img.shields.io/badge/-Instagram-%23eb13a5" alt="Instagram" /></a>
<a href="https://www.linkedin.com/in/johandre">
<img src="https://img.shields.io/badge/-LinkedIn-%233781da" alt="LinkedIn"/></a>
</p>

<!-- BODY -->
<!-- ABOUT THE PROJECT -->
## About The Project
<p align="center">
<img src="./Images/petulia-showcase-tinified 1.png" height="500"/>
<img src="./Images/petulia-showcase-tinified 2.png" height="500"/>
<img src="./Images/petulia-showcase-tinified 3.png" height="500"/>
<img src="./Images/petulia-showcase-tinified 4.png" height="500"/>
</p>

This is the source code for **Petulia**, my deep dive into SwiftUI. It is a native iOS app that helps you find shelter pets across the US. It consumes live data from the Petfinder's RESTful API and display results to the user in a modern and nice looking UI.

On the technical site I can highlight that it is reactive, fast, has nice animations, takes avantage of caching and it's a good iOS citizen.

## Built With

* [SwiftUI](https://developer.apple.com/xcode/swiftui/)
* [Combine](https://developer.apple.com/documentation/combine)
* [Swift Package Manager](https://github.com/apple/swift-package-manager)
* [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
* [Petfinder API](https://www.petfinder.com/developers/v2/docs/)

<!-- GETTING STARTED -->
## Installation
Petulia is available on the [App Store](https://apps.apple.com/tt/developer/johandre-delgado-moreno/id1289898741)

Follow this steps to get a local copy up and running:
1. Clone the repo
2. Get your credentials from [Petfinder](https://www.petfinder.com/developers/v2/docs/#using-the-api)
3. Install dependencies
4. Add it to your code here:

```Swift
class APIService: NetworkService {

  // Leaving them here for cloners convenience, but better to keep in your server.
  private let apiKey = "YOUR-API-KEY"
  private let secret =  "YOUR-SECRET-GOES-HERE"
  //...
  }
```

## Contribuiting
This is an open source project, feel free to fork and open a pull request.

### TO-DO:

- [x] Fix typos
- [ ] Add more filters
- [ ] Add more sorting options
- [ ] Add unit test

## Gift to shelters and rescue organizations
Reach out if you need to connect your backend and rebrand this app for your shelter. I will happily assit you, as much as I can, free of charge.


## Special Thanks

Special thanks to [Jeff](https://twitter.com/jefframes), [Ray](https://twitter.com/RayFromVA),  [Victoria](https://twitter.com/VicDevPiano) and all the awesome people at the [RW Bootcamp](https://www.raywenderlich.com/13699056-meet-the-2020-graduates-of-our-ios-android-bootcamps).

## Contact
* [Follow Me On Twitter](https://twitter.com/EsMoscu)
* [Available For Work On My Site](https://www.seadeveloper.com)

## License

Published under the [Apache License 2.0](https://github.com/bigimot22/Petulia-Open/blob/main/LICENSE).
You are free to use this project to learn or build your own, just don't republish as is as your own.
<br />
<br />
<!-- FOOTER -->

