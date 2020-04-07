import 'dart:convert';

CoronaGlobal responseCoronaFromJson(String str) => CoronaGlobal.fromJson(json.decode(str));

String responseCoronaToJson(CoronaGlobal data) => json.encode(data.toJson());

class CoronaGlobal {
  int status;
  String kasus;
  String meninggal;
  String sembuh;
  List<Global> listGlobal;
  String source;

  CoronaGlobal({
    this.status,
    this.kasus,
    this.meninggal,
    this.sembuh,
    this.listGlobal,
    this.source,
  });

  factory CoronaGlobal.fromJson(Map<String, dynamic> json) => CoronaGlobal(
    status: json["status"],
    kasus: json["kasus"],
    meninggal: json["meninggal"],
    sembuh: json["sembuh"],
    listGlobal: List<Global>.from(json["results"].map((x) => Global.fromJson(x))),
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "kasus": kasus,
    "meninggal": meninggal,
    "sembuh": sembuh,
    "results": List<dynamic>.from(listGlobal.map((x) => x.toJson())),
    "source": source,
  };
}

class Global {
  String negara;
  String kasus;
  String kasusBaru;
  String meninggal;
  String sembuh;

  Global({
    this.negara,
    this.kasus,
    this.kasusBaru,
    this.meninggal,
    this.sembuh,
  });

  factory Global.fromJson(Map<String, dynamic> json) => Global(
    negara: json["negara"],
    kasus: json["kasus"],
    kasusBaru: json["kasus_baru"],
    meninggal: json["meninggal"],
    sembuh: json["sembuh"],
  );

  Map<String, dynamic> toJson() => {
    "negara": negara,
    "kasus": kasus,
    "kasus_baru": kasusBaru,
    "meninggal": meninggal,
    "sembuh": sembuh,
  };
}
