import 'dart:io';

class TestConstructor {
  String testPath = "";
  int amount = 0;
  int choices = 0;
  String title = "";
  String dataPath = "";
  List<String> contents = [];
  List<List<String>> questions = [];
  List<int> correctIndexes = [];
  List<String> attachments = [];

  TestConstructor(String path) {
    testPath = path;
    var folderName = path.split("\\").last;
    dataPath = path + "\\" + folderName;
    readFile();
    parseFile();
  }

  void readFile() {
    List<String> lines = File(dataPath).readAsLinesSync();
    for (var line in lines) {
      contents.add(line);
    }
  }

  void parseFile() {
    print("PARSING");
    amount = int.parse(contents[0].split(" ").last);
    title = contents[1].split(" ").last;
    choices = int.parse(contents[2].split(" ").last);
    correctIndexes = List.generate(amount, (index) => 0);
    questions = List.generate(amount, (index) => []);
    attachments = List.generate(amount, (index) => "NULL");
    for (int i = 1; i <= amount; i++) {
      for (int j = 0; j < choices + 4; j++) {
        var temp = contents[j * i + 4];
        if (temp.contains("=")) {
          continue;
        } else if (temp.contains("QUESTION")) {
          questions[i - 1].add(temp.split(" ").last);
        } else if (temp.contains("ATTACH")) {
          attachments[i - 1] = temp.split(" ").last;
        } else if (temp.contains("CORRECT")) {
          correctIndexes[i - 1] = int.parse(temp.split(" ").last);
        } else {
          questions[i - 1].add(temp.split(" ").last);
        }
      }
    }
    print("DONE PARSING");
  }
}
