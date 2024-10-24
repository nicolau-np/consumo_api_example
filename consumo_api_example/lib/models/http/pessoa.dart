

import '../texto.dart';

class TextosResponse {
  List<Texto>? data;

  TextosResponse({this.data});

  TextosResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Texto>[];
      json['data'].forEach((v) {
        data!.add(new Texto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}