// To parse this JSON data, do
//
//     final tickerList = tickerListFromJson(jsonString);

import 'dart:convert';

TickerList tickerListFromJson(String str) => TickerList.fromJson(json.decode(str));

String tickerListToJson(TickerList data) => json.encode(data.toJson());

class TickerList {
  TickerList({
    this.tickerInfo,
  });

  List<TickerInfo>? tickerInfo;

  factory TickerList.fromJson(Map<String, dynamic> json) => TickerList(
    tickerInfo: json["ticker_info"] == null ? null : List<TickerInfo>.from(json["ticker_info"].map((x) => TickerInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ticker_info": tickerInfo == null ? null : List<dynamic>.from(tickerInfo!.map((x) => x.toJson())),
  };
}

class TickerInfo {
  TickerInfo({
    this.id,
    this.name,
    this.logoUrl,
  });

  String? id;
  String? name;
  String? logoUrl;

  factory TickerInfo.fromJson(Map<String, dynamic> json) => TickerInfo(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    logoUrl: json["logo_url"] == null ? null : json["logo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "logo_url": logoUrl == null ? null : logoUrl,
  };
}
