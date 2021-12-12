# Species Tracker

This is a coding assignment for Appsilon, by Andrew McNeil.

### Data Pre-processing

Data was split by country and saved as separate csv files.
The original file was ~20GB, far too large to use in a 
shiny app. By splitting the data by country and removing
unused column the data size can be greatly reduced.

```
sudo npm install -g @aleung/csvsplit
csvsplit -c 22 -o \
  ./preprocessed-data \
  ./biodiversity-data/occurence.csv
```

### App Flow

- A list of countries is determined by the file names
- This populates the country selector
- The species occurrence data is filtered by country
- Based on this filtered data, the species selectors are 
populated
- The scientific or vernacular name can be chosen
- Whichever is chosen will automatically update the other to
keep them in sync
- The data is filtered again for a particular species
- Based on this data, the date range selector is populated
with the min and max observance dates in the data
- The user can then optionally filter by date
- The final data is displayed on the map and bar plot

### Notes

- Some values of `vernacularName` were missing. For this 
app I chose to remove these values, but if they were kept
modification to the app logic would be required.
- There were also duplicate rows in the data, which I removed.
I don't have enough context about the data to know why this would be.
- This app is responsive and should work on mobile. 
However, there seems to be a bug with `plotlyOutput`,
and the plot is resizing incorrectly, throwing off the 
layout of the entire app. I would need to investigate
further to solve this issue.
- This app includes multiple uses of `updateSelectInput`.
To fully test the modules which update the UI, shinytest
should be used to test these portions of the app once the 
UI is stable.

### Extras

- Extra CSS has been used for the layout and custom 
bootstrap styling using the bslib package.
- Performance has been optimized to a reasonable degree
with the pre-processing of the data into partitions by country.
