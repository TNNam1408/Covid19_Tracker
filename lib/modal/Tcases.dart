class Tcases{
  var cases;
  var deaths;
  var recovered;
  // var updated;
  var todayCases;
  var todayDeaths;
  var todayRecovered;
  var affectedCountries;


  Tcases(
      {this.cases,
        this.deaths,
        this.recovered,
        this.todayCases,
        this.todayDeaths,
        this.todayRecovered,
        this.affectedCountries});

  factory Tcases.fromJson(final json){
    return Tcases(
      cases: json["cases"],
      deaths:  json["deaths"],
      recovered: json["recovered"],
      todayCases: json["todayCases"],
      todayDeaths: json["todayDeaths"],
      todayRecovered: json["todayRecovered"],
      affectedCountries: json["affectedCountries"],
    );
  }
}