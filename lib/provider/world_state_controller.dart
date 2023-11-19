import 'package:covid19_app_restapi/models/all_countries_model.dart';
import 'package:covid19_app_restapi/models/covid_19_model.dart';
import 'package:covid19_app_restapi/services/covid19_api_services.dart';
import 'package:flutter/material.dart';

class CovidDataProvider extends ChangeNotifier {
  final CovidApiServices _apiService = CovidApiServices();
  WorldStatesModel? _covidData;

  // get Data Api
  // List<AllCountriesModel> get getAllCountriesData => _allCountriesData;
  WorldStatesModel? get covidData => _covidData;
// Search perform Here
  List<AllCountriesModel> _allCountriesData = [];
  List<AllCountriesModel> _filteredCountries = []; // Filtered country data list

  // Getter for the filtered country list
  List<AllCountriesModel> get filteredCountries => _filteredCountries;

  Future<void> fetchCovidData() async {
    try {
      _covidData = await _apiService.fetchCovidData();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchAllCountriesData() async {
    try {
      _allCountriesData = await _apiService.fetchAllCountriesData();
         _filteredCountries = List.from(_allCountriesData);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterCountries(String searchText) {
    if (searchText.isEmpty) {
      // If search text is empty, show all countries
      _filteredCountries = List.from(_allCountriesData);
    } else {
      // Filter countries based on the search text
      _filteredCountries = _allCountriesData
          .where((country) =>
              country.country!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
