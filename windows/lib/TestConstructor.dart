import 'dart:io';

class TestConstructor {
  //Variables used in working with test
  String testPath = "";
  String imagePath = "";
  int amount = 0;
  int choices = 0;
  String title = "";
  String dataPath = "";
  //Lists with important test data
  List<String> contents = [];
  List<List<String>> questions = [];
  List<int> correctIndexes = [];
  List<int> selectedIndexes = [];
  List<String> attachments = [];

  TestConstructor(String path) {
    ///Constructor for test data managment
    testPath = path;
    var folderName = path.split("\\").last;
    dataPath = path + "\\" + folderName;
    imagePath = path + "\\images\\";
    readFile(); //Read file
    parseFile(); //Parse file
  }

  void readFile() {
    ///Read test file and load its conents into memory
    List<String> lines = File(dataPath).readAsLinesSync();
    for (var line in lines) {
      contents.add(line);
    }
  }

  void parseFile() {
    ///Parse test file
    //Begin with initializing a lot of needed variables
    //Read header of file and parse it
    amount = int.parse(contents[0].split("|").last);
    title = contents[1].split("|").last;
    choices = int.parse(contents[2].split("|").last);
    //Initialize lists
    correctIndexes = List.generate(amount, (index) => 0);
    questions = List.generate(amount, (index) => []);
    attachments = List.generate(amount, (index) => "NULL");
    selectedIndexes = List.generate(amount, (index) => 0);
    //Define question chunk size
    int chunkSize = choices + 4;
    //Start parsing chunks of data
    for (int i = 0; i < amount; i++) {
      for (int j = 0; j < chunkSize; j++) {
        var temp = contents[3 + j + i * chunkSize];
        if (temp.contains("=")) {
          continue;
        } else if (temp.contains("QUESTION")) {
          //Read question
          questions[i].add(temp.split("|").last);
        } else if (temp.contains("ATTACH")) {
          //Read atachment data
          attachments[i] = temp.split("|").last;
        } else if (temp.contains("CORRECT")) {
          //Read correct index
          correctIndexes[i] = int.parse(temp.split("|").last);
        } else {
          //Read answer choices
          questions[i].add(temp.split("|").last);
        }
      }
    }
  }
}
