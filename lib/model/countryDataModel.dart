
class CountryDataList {
  final List<CountryData> countries;

  CountryDataList({this.countries});

  factory CountryDataList.fromJson(List<dynamic> parsedJson) {
    List<CountryData> country = new List<CountryData>();
    country = parsedJson.map((i) => CountryData.fromJSON(i)).toList();
    return new CountryDataList(countries: country);
  }
}

class CountryData {
  final String countryName;
  final int countryCases;
  final int countryDeaths;
  final String countryRecovered;
  final int todayCases;
  final int todayDeaths;
  final int activeCases;
  final int critCases;
  final int totalTests;

  CountryData(
      {this.activeCases,
      this.critCases,
      this.totalTests,
      this.todayCases,
      this.todayDeaths,
      this.countryName,
      this.countryCases,
      this.countryDeaths,
      this.countryRecovered});

  factory CountryData.fromJSON(Map<String, dynamic> json) {
    return CountryData(
        countryName: json['country'],
        countryCases: json['cases'],
        countryDeaths: json['deaths'],
        countryRecovered: json['recovered'].toString(),
        todayCases: json['todayCases'],
        todayDeaths: json["todayDeaths"],
        activeCases: json['active'],
        critCases: json["critical"],
        totalTests: json["totalTests"]);
  }
}
