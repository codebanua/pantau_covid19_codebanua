// To parse this JSON data, do
//
//     final responseNews = responseNewsFromJson(jsonString);

import 'dart:convert';

ResponseNews responseNewsFromJson(String str) => ResponseNews.fromJson(json.decode(str));

String responseNewsToJson(ResponseNews data) => json.encode(data.toJson());

class ResponseNews {
  int status;
  List<ItemBerita> results;
  String source;

  ResponseNews({
    this.status,
    this.results,
    this.source,
  });

  factory ResponseNews.fromJson(Map<String, dynamic> json) => ResponseNews(
    status: json["status"],
    results: List<ItemBerita>.from(json["results"].map((x) => ItemBerita.fromJson(x))),
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "source": source,
  };
}

class ItemBerita {
  String judul;
  String link;
  String gambar;

  ItemBerita({
    this.judul,
    this.link,
    this.gambar,
  });

  factory ItemBerita.fromJson(Map<String, dynamic> json) => ItemBerita(
    judul: json["judul"],
    link: json["link"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "judul": judul,
    "link": link,
    "gambar": gambar,
  };
}
