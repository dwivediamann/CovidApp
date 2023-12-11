import 'dart:convert';

import 'package:covid_tracker/Model/world_state_model.dart';
import 'package:covid_tracker/Service/utility/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  // data is loaded from the Api so
  Future<WorldStatesModel> fetechapi() async {
    final response = await http.get(Uri.parse(Appurl.worldstateapi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countrylistapi() async {
    var data;
    final response = await http.get(Uri.parse(Appurl.countryList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
