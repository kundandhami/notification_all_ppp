import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderDataCity extends ChangeNotifier {
  AllData dataAll = AllData(error: false, msg: "msg", data: []);
  bool loadings = true;
  getData() async {
    final res = await http
        .get(Uri.parse("https://countriesnow.space/api/v0.1/countries/states"));
    dataAll = allDataFromJson(res.body);
    loadings = false;
    filterStateName();
  }

  String serachname = "";
  List states = [];

  filterStateName() {
    states.clear();

    if (serachname.isEmpty) {
      dataAll.data.forEach((element) {
        if (element.states.isNotEmpty) {
          element.states.forEach((e) {
            states.add(e);
          });
        }
      });
    } else {
      dataAll.data.forEach((element) {
        states.addAll(element.states
            .where((element) =>
                element.name.toLowerCase().contains(serachname.toLowerCase()))
            .toList());
      });
    }

    notifyListeners();
  }

  void searchData(String data) {
    serachname = data;
    filterStateName();
  }
}

AllData allDataFromJson(String str) => AllData.fromJson(json.decode(str));

String allDataToJson(AllData data) => json.encode(data.toJson());

class AllData {
  bool error;
  String msg;
  List<Datum> data;

  AllData({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
        error: json["error"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String name;
  String iso3;
  String iso2;
  List<States> states;

  Datum({
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.states,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        states: List<States>.from(json["states"].map((x) => States.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class States {
  String name;
  String? stateCode;

  States({
    required this.name,
    this.stateCode,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        name: json["name"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "state_code": stateCode,
      };
}
