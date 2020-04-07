import 'package:coronamonitorapps/helper/map_helper.dart';
import 'package:coronamonitorapps/models/corona_detail_province.dart';
import 'package:coronamonitorapps/models/corona_global.dart';
import 'package:coronamonitorapps/models/corona_indo.dart';
import 'package:coronamonitorapps/network/service_corona.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoronaChangeNotifier with ChangeNotifier {
  CoronaChangeNotifier() {
    getDataGlobal();
  }

  ServiceCorona _service = ServiceCorona();
  bool _isFetching;

  bool get isFetching => _isFetching;

  CoronaGlobal _coronaGlobal;

  CoronaGlobal get coronaGlobal => _coronaGlobal;

  Future<void> getDataGlobal() async {
    _isFetching = true;
    notifyListeners();
    _coronaGlobal = await _service.getDataGlobal();
    _isFetching = false;
    notifyListeners();
  }

  CoronaIndo _coronaIndo;

  CoronaIndo get coronaIndo => _coronaIndo;

  Future<void> getDataIndo() async {
    _isFetching = true;
    notifyListeners();
    _coronaIndo = await _service.getDataIndo();
    _isFetching = false;
    notifyListeners();
  }

  CoronaDetailProvince _coronaDetailProvince;

  CoronaDetailProvince get coronaDetailProvince => _coronaDetailProvince;

  Future<void> getDataDetailProvince(int idProvince) async {
    _isFetching = true;
    notifyListeners();
    _coronaDetailProvince =
        await _service.getDataDetailProvince(idProvince).then((result) {
      result.listCity
          .sort((a, b) => int.parse(b.positif).compareTo(int.parse(a.positif)));
      return result;
    });
    _isFetching = false;
    notifyListeners();
  }

  List<dynamic> tempSearch = [];
  List<dynamic> itemSearched = [];
  int loop = 1;

  void searchCaseItemCorona(String keyword, String state) {
    if (keyword.isNotEmpty) {
      if (state == 'Global') {
        if (loop == 1) {
          tempSearch.clear();
          tempSearch.addAll(coronaGlobal.listGlobal);
        }
        coronaGlobal.listGlobal.clear();
        tempSearch.forEach((item) {
          if (item.negara.toLowerCase().contains(keyword)) {
            itemSearched.add(item);
          }
        });
        coronaGlobal.listGlobal.addAll(itemSearched.cast());
        itemSearched.clear();
      } else if (state == 'Indonesia') {
        if (loop == 1) {
          tempSearch.clear();
          tempSearch.addAll(coronaIndo.listProvince);
        }
        coronaIndo.listProvince.clear();
        tempSearch.forEach((item) {
          if (item.provinsi.toLowerCase().contains(keyword)) {
            itemSearched.add(item);
          }
        });
        coronaIndo.listProvince.addAll(itemSearched.cast());
        itemSearched.clear();
      } else {
        if (loop == 1) {
          tempSearch.clear();
          tempSearch.addAll(coronaDetailProvince.listCity);
        }
        coronaDetailProvince.listCity.clear();
        tempSearch.forEach((item) {
          if (item.nama.toLowerCase().contains(keyword)) {
            itemSearched.add(item);
          }
        });
        coronaDetailProvince.listCity.addAll(itemSearched.cast());
        itemSearched.clear();
      }
    } else {
      resetItemSearch(state);
    }
    loop++;
    notifyListeners();
  }

  void resetItemSearch(String state) {
    if (state == 'Global') {
      coronaGlobal.listGlobal.clear();
      coronaGlobal.listGlobal.addAll(tempSearch.cast());
    } else if (state == 'Indonesia') {
      coronaIndo.listProvince.clear();
      coronaIndo.listProvince.addAll(tempSearch.cast());
    } else {
      coronaDetailProvince.listCity.clear();
      coronaDetailProvince.listCity.addAll(tempSearch.cast());
    }
//    tempSearch.clear();
    notifyListeners();
  }

  Set<Marker> marker = {};
  LatLngBounds latLngBounds;

  Future<void> getDataMapIndo() async {
    _isFetching = true;
    marker.clear();
    notifyListeners();

    List<Province> data = _coronaIndo.listProvince;

    List<LatLng> listlatLng = [];

    data.forEach((item) async {
      marker.add(Marker(
          markerId: MarkerId('${item.id}'),
          position:
              LatLng(double.parse(item.latitude), double.parse(item.longitude)),
          infoWindow: InfoWindow(
              snippet:
                  'Positif:${item.kasus}, Sembuh:${item.sembuh}, Meninggal:${item.meninggal}',
              title: '${item.provinsi}'),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              'assets/images/biohazard_mini.png')));
    });

    data.forEach((item) {
      listlatLng.add(
          LatLng(double.parse(item.latitude), double.parse(item.longitude)));
    });

    latLngBounds = MapHelper.boundsFromLatLngList(listlatLng);
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getDataMapProvince() async {
    _isFetching = true;
    marker.clear();
    notifyListeners();

    List<City> data = _coronaDetailProvince.listCity;
    List<LatLng> listlatLng = [];

    data.forEach((item) async {
      marker.add(Marker(
          markerId: MarkerId('${item.nama}'),
          position:
              LatLng(double.parse(item.latitude), double.parse(item.longitude)),
          infoWindow: InfoWindow(
              snippet:
                  'Positif:${item.positif}, Sembuh:${item.negatif}, Meninggal:${item.meninggal}',
              title: '${item.nama}: ODP:${item.odp}, PDP:${item.pdp}'),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              'assets/images/biohazard_mini.png')));
    });

    data.forEach((item) {
      listlatLng.add(
          LatLng(double.parse(item.latitude), double.parse(item.longitude)));
    });

    latLngBounds = MapHelper.boundsFromLatLngList(listlatLng);
    _isFetching = false;
    notifyListeners();
  }
}
