import 'package:flutter/foundation.dart';

enum Cinsiyet { kadin, erkek, diger }

enum Renkler { sari, mavi, yesil, pembe, kirmizi, mor }

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renkler;
  final bool ogrenciMi;

  UserInformation(this.isim, this.cinsiyet, this.renkler, this.ogrenciMi);

  Map<String, dynamic> toJson() {
    return {
      'isim': isim,
      'cinsiyet': describeEnum(cinsiyet), // cinsiyet ==>Cinsiyet.ERKEK ==>ERKEK
      'renkler': renkler,
      'ogrenciMi': ogrenciMi
    };
  }

  UserInformation.fromJson(Map<String, dynamic> json)
      : isim = json['isim'],
        cinsiyet = Cinsiyet.values.firstWhere(
            (element) => describeEnum(element).toString() == json['cinsiyet']),
        // ERKEK ==> Cinsiyet.ERKEK
        renkler = List<String>.from(json['renkler']),
        ogrenciMi = json['ogrenciMi'];
}
