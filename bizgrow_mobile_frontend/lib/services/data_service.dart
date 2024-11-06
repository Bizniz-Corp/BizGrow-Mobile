import 'dart:convert';
import 'dart:io';



Future<List<dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();

  return jsonDecode(input) as List<dynamic>;
}

Future<void> main() async {
  print('test');
  List<dynamic> data = await readJsonFile(
      '../assets/data/data_dummy.json');

  if (data != null) {
    print('${data[0]['value']}');
  } else {
    print('No');
  }
}
