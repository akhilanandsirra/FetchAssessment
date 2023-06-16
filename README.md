# Native iOS Dessert App

Developed a native iOS app that allows users to browse dessert recipes using the [MealDB API](https://themealdb.com/api.php) for Fetch iOS Coding Challenge.

The app utilizes two endpoints:

- [https://themealdb.com/api/json/v1/1/filter.php?c=Dessert](https://themealdb.com/api/json/v1/1/filter.php?c=Dessert) for fetching the list of meals in the Dessert category.
- [https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID](https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID) for fetching the meal details by its ID.

The app displays a list of meals in the Dessert category, sorted alphabetically. When the user selects a meal, they are taken to a detail view that includes the following information:

- Meal name
- Instructions
- Ingredients/measurements

## Instructions

1. Clone the Github repository onto your local machine. You can use the command line or a Git client like GitKraken to do this. For example, if you have Git installed on your machine, you can run the following command in your terminal:
```[terminal]
git clone https://github.com/akhilanandsirra/FetchAssessment/
```
2. Open Xcode and select "Open a project or file" from the startup screen.
3. Navigate to the folder where you cloned the repository and select the .xcodeproj file.

4. Once the project is open in Xcode, select a device or simulator to run the app on from the top left-hand corner of the Xcode window.

5. Build and run the app by pressing the "Run" button in the top left-hand corner of the Xcode window.

6. If there are any errors or missing dependencies, Xcode will prompt you to install them.

That's it! the iOS app should now be running on the selected device or simulator.

## Highlights

- To improve user experience, I implemented the `.searchable` view modifier to enable filtering of the list of desserts
- To ensure the reliability of my code, I used `XCTest` to write unit tests that specifically targeted the JSON decoding process & parsing model data
- To maintain code organization and separation of concerns, I chose to use the `MVVM` architecture, which separates models, views, and business logic
- To download and cache the image data, I used `UIImageView` extension
- To fetch the Data from API, Implemented a generic Networking Layer 
- To keep up with modern development practices, I opted for the newer `async/await` methods of URLSession
- To ensure consistent visual design, I used colors that comply with both dark and light modes. Additionally, to provide a more immersive experience, I included a "watch video" button that takes the user to the recipe video in the detail view
- To ensure that the app displays only meaningful data, I added a filter to remove any `null` or `empty` values from the API before displaying them
