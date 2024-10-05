import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_19_tracker/Models/WorldStatesModel.dart';
import 'package:covid_19_tracker/Services/Utilities/appURL.dart';

class Statesservices {
 
  Future<WorldStatesModel> FechWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
   
  Future<List<dynamic>> CountriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
 var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
     
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
