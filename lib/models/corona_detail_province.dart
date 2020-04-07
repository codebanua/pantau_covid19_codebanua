import 'dart:convert';

CoronaDetailProvince coronaDetailProvinceFromJson(String str) => CoronaDetailProvince.fromJson(json.decode(str));

String coronaDetailProvinceToJson(CoronaDetailProvince data) => json.encode(data.toJson());

class CoronaDetailProvince {
  int status;
  String provinsi;
  String kasus;
  String meninggal;
  String sembuh;
  String pdp;
  String odp;
  List<City> listCity;
  String source;

  CoronaDetailProvince({
    this.status,
    this.provinsi,
    this.kasus,
    this.meninggal,
    this.sembuh,
    this.pdp,
    this.odp,
    this.listCity,
    this.source,
  });

  factory CoronaDetailProvince.fromJson(Map<String, dynamic> json) => CoronaDetailProvince(
    status: json["status"],
    provinsi: json["provinsi"],
    kasus: json["kasus"],
    meninggal: json["meninggal"],
    sembuh: json["sembuh"],
    pdp: json["pdp"],
    odp: json["odp"],
    listCity: List<City>.from(json["results"].map((x) => City.fromJson(x))),
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "provinsi": provinsi,
    "kasus": kasus,
    "meninggal": meninggal,
    "sembuh": sembuh,
    "pdp": pdp,
    "odp": odp,
    "results": List<dynamic>.from(listCity.map((x) => x.toJson())),
    "source": source,
  };
}

class City {
  String nama;
  String positif;
  String negatif;
  String odp;
  String pdp;
  String meninggal;
  String latitude;
  String longitude;

  City({
    this.nama,
    this.positif,
    this.negatif,
    this.odp,
    this.pdp,
    this.meninggal,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    nama: json["nama"],
    positif: json["positif"],
    negatif: json["negatif"],
    odp: json["odp"],
    pdp: json["pdp"],
    meninggal: json["meninggal"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "positif": positif,
    "negatif": negatif,
    "odp": odp,
    "pdp": pdp,
    "meninggal": meninggal,
    "latitude": latitude,
    "longitude": longitude,
  };
}
