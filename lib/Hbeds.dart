class Hbeds{
  var ruralHospitals;
  var ruralBeds;
  var urbanHospitals;
  var urbanBeds;
  var totalHospitals;
  var totalBeds;

  Hbeds({this.ruralHospitals,this.ruralBeds,this.urbanHospitals,this.urbanBeds,this.totalHospitals,this.totalBeds});
  factory Hbeds.fromJson(final json)
  {
    return Hbeds(
      ruralHospitals:json["ruralHospitals"],
      ruralBeds : json["ruralBeds"],
      urbanHospitals : json["urbanHospitals"],
      urbanBeds : json["urbanBeds"],
      totalHospitals : json["totalHospitals"],
      totalBeds : json["totalBeds"],
    );
  }
}