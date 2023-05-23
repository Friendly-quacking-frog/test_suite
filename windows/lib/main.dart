import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Suite',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Test Suite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDirectory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Center(
                    child: Banner(
              location: BannerLocation.topEnd,
              message: "Under Construction",
              color: Colors.orange,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(400, 400),
                  backgroundColor: Colors.blue,
                  disabledForegroundColor: Colors.red.withOpacity(0.38),
                  disabledBackgroundColor: Colors.red.withOpacity(0.12),
                ),
                onPressed: () {
                  print("Create");
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_circle_outline_outlined),
                    Text('Создать тест')
                  ],
                ),
              ),
            ))),
            Expanded(
                child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(400, 400),
                  backgroundColor: Colors.blue,
                  disabledForegroundColor: Colors.red.withOpacity(0.38),
                  disabledBackgroundColor: Colors.red.withOpacity(0.12),
                ),
                onPressed: () async {
                  print("Open");
                  selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();
                  if (selectedDirectory == null) {
                    // User canceled the picker
                  } else {
                    print(selectedDirectory);
                  }
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.upload_file), Text('Открыть тест')],
                ),
              ),
            )),
          ],
        )));
  }
}
