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
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: xml.isEmpty
          ? const SizedBox.shrink()
          : GpxView(
              xml: xml,
            ),
    );
  }
}
