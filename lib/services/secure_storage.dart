import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  late final FlutterSecureStorage preferences;

  SecureStorageService() {
    debugPrint('secure storage kurucusu calıstı');
    preferences = const FlutterSecureStorage();
  }

  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    final name = userInformation.isim;
    await preferences.write(key: 'isim', value: name);
    await preferences.write(
        key: 'ogrenci', value: userInformation.ogrenciMi.toString());
    await preferences.write(
        key: 'cinsiyet', value: userInformation.cinsiyet.index.toString());
    await preferences.write(
        key: 'renkler', value: jsonEncode(userInformation.renkler));
  }

  @override
  Future<UserInformation> verileriOku() async {
    var isim = await preferences.read(key: 'isim') ?? '';

    var ogrenciString =
        await preferences.read(key: 'ogrenci') ?? 'false'; // 'true' / 'false'

    var ogrenci = ogrenciString.toLowerCase() == 'true' ? true : false;

    var cinsiyetString =
        await preferences.read(key: 'cinsiyet') ?? '0'; // '0', '1', '2'

    var cinsiyet = Cinsiyet.values[int.parse(cinsiyetString)];

    var renklerString = await preferences.read(key: 'renkler');

    var renkler = renklerString == null
        ? <String>[]
        : List<String>.from(jsonDecode(renklerString));

    return UserInformation(isim, cinsiyet, renkler, ogrenci);
  }
}
