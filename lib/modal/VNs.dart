class VNese{
  var lastUpdatedAtApify;
  var lastUpdatedAtSource;
  var infected;
  var treated;
  var recovered;
  var deceased;


  VNese(
      {this.lastUpdatedAtApify,
      this.lastUpdatedAtSource,
      this.infected,
      this.treated,
      this.recovered,
      this.deceased});

  factory VNese.fromJson(final json){
    return VNese(
      lastUpdatedAtApify: json["lastUpdatedAtApify"],
      lastUpdatedAtSource:  json["lastUpdatedAtSource"],
      infected: json["infected"],
      treated: json["treated"],
      recovered: json["recovered"],
      deceased: json["deceased"],
    );
  }
}