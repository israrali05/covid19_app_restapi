import 'dart:convert';
import 'package:covid19_app_restapi/models/all_countries_model.dart';
import 'package:covid19_app_restapi/models/covid_19_model.dart';
import 'package:covid19_app_restapi/services/app_url/app_url.dart';
import 'package:http/http.dart' as http;
class CovidApiServices{
 Future<WorldStatesModel> fetchCovidData() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
  
   Future<List<AllCountriesModel>> fetchAllCountriesData() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => AllCountriesModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}