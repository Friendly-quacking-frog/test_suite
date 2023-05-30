import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:windows/TestConstructor.dart';
import 'package:windows/TestPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDirectory;
  late TestConstructor testConstructor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Button to enter test construction mode
            //TODO: question constriction mode
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
            //Button to enter question loading mode
            Expanded(
                child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(400, 400),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  //Open default Window directory selector on press
                  selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();
                  if (selectedDirectory == null) {
                    //User canceled the picker
                  } else {
                    //User selected some directory
                    //TODO: check for validiy of folder
                    //Right now we can only pray that its correct
                    testConstructor = TestConstructor(selectedDirectory!);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TestPage(
                              constructor: testConstructor,
                              pageIndex: 0,
                            )));
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
