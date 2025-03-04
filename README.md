## iOS apps Countries created by ChatGPT 4.o3-mini and Groc 3 xAI

 Discover the nations of the world with the Countries iOS application. Built with cutting-edge AI from ChatGPT 4.o3-mini and Groc 3 xAI, this app presents countries organized by region, including Europe, Asia, and Latin America.  For each country, access key information: official name, flag, population figures, GDP data, and a detailed map view showcasing its location and borders.
 
 We used World Bank data, but we did not tell the AI ​​either the sites or the data structures, 
 the AI ​​should find all this itself and use them when creating an iOS application.

 We ask Groc 3 xAI to  model a country border as a polygon using geo coordinates in SwiftUI with MapKit for iOS 17.
 After evaluating multiple sources, [martynafford/natural-earth-geojson](https://github.com/martynafford/natural-earth-geojson) is recommended for its recency (January 24, 2024), direct GEOJSON availability, and alignment with Natural Earth's latest data. 

 
 ![til](https://github.com/BestKora/CountryChatGPTBorders/blob/7fcd706045940c493d5906365d6448cada81a56d/Borders.gif)

## Technologies used by ChatGPT o3-mini:

* MVVM design pattern 
* SwiftUI
* async / await
* Swift 6 strict concurrency using @MainActor and marking selection functions as nonisolated or using Task.detached.
*  API with Map (position: $position) and Maker
*  CLGeocoder() to get more accurate geographic coordinates of the country's capital and Task.detached to run in the background.
  
## Results of using ChatGPT o3-mini:

* Coped with decoding JSON data without any problems
* Used a modern async / await system for working with multithreading.
Suggested several options for switching to Swift 6 strict concurrency using @MainActor and marking selection functions as nonisolated or using Task.detached.
* At first, I suggested the old Map API with Map (coordinateRegion: $region, annotationItems: [country]) and MapMaker, but after receiving the corresponding warnings, I switched to the new API with Map (position: $position) and Maker.
* Used CLGeocoder() to get more accurate geographic coordinates of the country's capital and Task.detached to run in the background.
* The reasoning is short, to the point and lasts from 1 to 25 seconds, the average time is 8 seconds.
* I can recommend it as a good training material for iOS developers.

## "Thinking" AI Groc 3 xAI :

* After evaluating several sources of country border data, recommended the martynafford/natural-earth-geojson repository due to its newness (January 24, 2024), direct availability of GeoJSON, and its compliance with the latest Natural Earth data.
* Provided code for two ways to decode JSON data: MKGeoJSONDecoder() in MapKit and the standard JSONDecoder()
* Used modern async / await multithreaded fetching of JSON data from the web
* Integrated country border data into SwiftUI Map View
* Can handle non-standard JSON data perfectly
* Proved to be an effective and reliable assistant in iOS programming
