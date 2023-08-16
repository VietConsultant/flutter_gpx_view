# flutter_gpx_view

A Flutter package for displaying GPX data on a map. This package utilizes the [flutter_map](https://pub.dev/packages/flutter_map) package for map rendering and [xml](https://pub.dev/packages/xml) package for parsing GPX data. The map tiles are provided by [OpenTopoMap](https://opentopomap.org).

## Features

- Display GPX data on a map.
- Customize the color and stroke width of the polyline.
- Customize the marker icon for waypoints.
- Set padding for the map bounds.
- Utilizes Flutter's native `Tooltip` widget for waypoint information.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_gpx_view: 
    git: 
      url: git@github.com:VietConsultant/flutter_gpx_view.git
```

# Usage
Import the package:

```dart
import 'package:flutter_gpx_view/flutter_gpx_view.dart';
```

Use the `GpxView` widget to display the GPX data:

```dart
GpxView(
  xml: yourGpxXmlString, // Provide your GPX data XML string here
  polyColor: Colors.blueAccent, // Customize the polyline color
  markerIcon: Icon(
    Icons.location_on,
    color: Colors.red,
  ), // Customize the waypoint marker icon
  polyStrokeWidth: 4.0, // Customize the polyline stroke width
  boundPadding: EdgeInsets.all(20.0), // Customize the map bounds padding
)
```

Make sure to replace yourGpxXmlString with your actual GPX data XML string.

# Example

Here's a complete example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gpx_view/flutter_gpx_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String xml = '';

  @override
  void initState() {
    _loadAsset();
    super.initState();
  }

  Future<void> _loadAsset() async {
    final gpxString = await rootBundle.loadString('assets/sample.xml');

    setState(() {
      xml = gpxString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: xml.isEmpty
          ? const SizedBox.shrink()
          : SizedBox(
              width: 300,
              height: 200,
              child: GpxView(
                xml: xml,
              ),
            ),
    );
  }
}
```

Replace the `assets/sample.xml` with your actual GPX data XML file or string.

# Contributions
Contributions are welcome! If you encounter any issues or would like to suggest improvements, please open an issue on [GitHub](git@github.com:VietConsultant/flutter_gpx_view.git).

# License

This package is released under the MIT License.