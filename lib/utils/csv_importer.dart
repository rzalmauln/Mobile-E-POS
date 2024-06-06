import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CSVImporter {

  Future<List<Map<String, dynamic>>> readCSV(String filePath) async {
    final file = File(filePath);

    if(!await file.exists()) {
      throw Exception('File not found at $filePath');
    }

    final csvString = await file.readAsString();
    final List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

    final List<String> headers = csvData.first.cast<String>();

    List<Map<String, dynamic>> dataList = [];
    for(var i = 1; i < csvData.length; i++) {
      Map<String, dynamic> rowMap = {};
      for(var j = 0; j < headers.length; j++) {
        rowMap[headers[j]] = csvData[i][j];
      }
      dataList.add(rowMap);
    }

    return dataList;
  }

  Future<String> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv']
    );

    if (result != null) {
      print('CSV path: $result');
      // _importCSV(result.files.single.path!);
      return result.files.single.path!;
    } else {
      print('Error CSV Path');
      return '';
    }
  }

}