# Dijkstra's Algorithm for Gaza Strip Map

## Overview

This repository contains a Flutter desktop application that implements a highly optimized version of Dijkstra’s algorithm to compute the shortest paths on a map of the Gaza Strip. The application is designed to handle thousands of queries efficiently, demonstrating the shortest route between two selected cities with minimal computational resources.

## Features

- **Optimized Dijkstra’s Algorithm**: Fine-tuned for rapid calculation of shortest paths without excessive space usage.
- **Interactive Gaza Strip Map**: A detailed map interface that allows users to select cities and visualize routes.
- **Sublinear Query Time**: Processes shortest path queries in sublinear time after initial map preprocessing.
- **GIS-Ready**: Applicable for use in Geographic Information Systems (GIS) and navigation systems.
- **Efficient Data Handling**: Capable of managing a map with at least 50 cities, representing them accurately with their geographical coordinates.

## Screenshots

*Map Interface with Dijkstra’s Pathfinding*
![Map screen](https://github.com/3odeh/Gaza-strip-Map/assets/111912140/9a63d537-b0cc-4d73-907e-4bf4ac0390e3)


## Installation

To run this application on your system:

1. Clone this repository:
   ```
   git clone https://github.com/3odeh/Gaza-strip-Map.git
   ```
2. Navigate to the project directory:
   ```
   cd Gaza-strip-Map
   ```
3. Ensure you have Flutter installed and run the application:
   ```
   flutter run -d windows (or macos/linux)
   ```

## Usage

1. Use the mouse or keyboard to select a source and target city from the map or the dropdown menus.
2. Click `Run` to execute the algorithm and view the shortest path on the map.
3. The path, along with the total distance, will be displayed on the screen.

## Input File Format

The input file must follow the format below, listing the number of vertices (cities) and edges (roads), then the vertices with latitude and longitude, and finally the edges as pairs of vertices:

```
<number of vertices> <number of edges>
<City1> <latitude> <longitude>
<City2> <latitude> <longitude>
...
<City1> <City2>
<City2> <City3>
...
```

Example:

```
6 9
City1 31.52583 34.45250
City2 31.53389 35.09944
...
City1 City2
City1 City4
...
```

## Contributing

Contributions are what make the open-source community such a powerful platform for learning, inspiration, and collaboration. Any contributions you make are **greatly appreciated**.

