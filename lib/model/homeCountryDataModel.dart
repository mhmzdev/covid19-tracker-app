
class HomeStats {
  final int cases;
  final int tested;
  final int deaths;
  final int recovered;
  final String latestUpdated;
  HomeStats(
      {this.cases,
      this.latestUpdated,
      this.tested,
      this.deaths,
      this.recovered});

  factory HomeStats.fromJSON(Map<String, dynamic> json) {
    return HomeStats(
        cases: json['infected'],
        tested: json['tested'],
        deaths: json['deceased'],
        recovered: json["recovered"],
        latestUpdated: json["lastUpdatedAtApify"]);
  }
}
