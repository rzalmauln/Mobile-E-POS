import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CSVExporter {

  Future<void> exportToCSV<T>(String tablename, List<T> data) async {
    if(data.isEmpty) {
      print('No data to be exported!');
      return;
    }

    String csv = convertToCSV(data);
    try {
      await saveCSV(csv, tablename);
    } catch(e) {
      print('Error saving CSV: $e');
    }
  }

  String convertToCSV<T>(List<T> data) {
    List<List<dynamic>> rows = [];
    var firstObj = (data.first as dynamic).toJson() as Map<String, dynamic>;
    List<String> headers = firstObj.keys.map((key) => key.toString()).toList();
    rows.add(headers);

    for(var obj in data) {
      var values = (obj as dynamic).toJson() as Map<String, dynamic>;
      rows.add(values.values.map((value) => value.toString()).toList());
    }

    return const ListToCsvConverter().convert(rows);
  }

  Future<void> saveCSV(String csv, String tablename) async {
    try {
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/${tablename}_data.csv';
      final file = File(path);

      await file.writeAsString(csv);
      print('CSV saved at $path');
    } catch(e) {
      print('Error saveCSV: $e');
    } finally {
      print('CSV saved ');
    }
  }


}