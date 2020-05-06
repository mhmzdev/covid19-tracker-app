import 'dart:convert';
import 'package:covid19/model/globalDataModel.dart';
import 'package:covid19/model/homeCountryDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/model/countryDataModel.dart';

class CovidAPI {
  
  Future<GlobalData> getCase() async {
    String url = 'https://coronavirus-19-api.herokuapp.com/all';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GlobalData.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load Post");
    }
  }
  
  Future<HomeStats> getHomeCase() async {
    String url =
        'https://api.apify.com/v2/key-value-stores/QhfG8Kj6tVYMgud6R/records/LATEST?disableRedirect=true';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return HomeStats.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load Post");
    }
  }

  Future<CountryDataList> getCountryData() async {
    String url = 'https://coronavirus-19-api.herokuapp.com/countries';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      return CountryDataList.fromJson(jsonRes);
    } else {
      throw Exception("Failed due to Network Error");
    }
  }
}