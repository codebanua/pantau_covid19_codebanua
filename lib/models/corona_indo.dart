// To parse this JSON data, do
//
//     final coronaProvince = coronaProvinceFromJson(jsonString);

import 'dart:convert';

CoronaIndo coronaProvinceFromJson(String str) => CoronaIndo.fromJson(json.decode(str));

String coronaProvinceToJson(CoronaIndo data) => json.encode(data.toJson());

class CoronaIndo {
  int status;
  String kasus;
  String meninggal;
  String sembuh;
  List<Province> listProvince;
  String source;

  CoronaIndo({
    this.status,
    this.kasus,
    this.meninggal,
    this.sembuh,
    this.listProvince,
    this.source,
  });

  factory CoronaIndo.fromJson(Map<String, dynamic> json) => CoronaIndo(
    status: json["status"],
    kasus: json["kasus"],
    meninggal: json["meninggal"],
    sembuh: json["sembuh"],
    listProvince: List<Province>.from(json["results"].map((x) => Province.fromJson(x))),
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "kasus": kasus,
    "meninggal": meninggal,
    "sembuh": sembuh,
    "results": List<dynamic>.from(listProvince.map((x) => x.toJson())),
    "source": source,
  };
}

class Province {
  String id;
  String provinsi;
  int kasus;
  int sembuh;
  int meninggal;
  String latitude;
  String longitude;

  Province({
    this.id,
    this.provinsi,
    this.kasus,
    this.sembuh,
    this.meninggal,
    this.latitude,
    this.longitude,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"],
    provinsi: json["provinsi"],
    kasus: json["kasus"],
    sembuh: json["sembuh"],
    meninggal: json["meninggal"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provinsi": provinsi,
    "kasus": kasus,
    "sembuh": sembuh,
    "meninggal": meninggal,
    "latitude": latitude,
    "longitude": longitude,
  };
}
