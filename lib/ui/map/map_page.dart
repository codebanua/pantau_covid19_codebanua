import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/widgets/custom_chip/custom_chip_range.dart';
import 'package:coronamonitorapps/widgets/header_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  static final double latitude = -6.1953021;
  static final double longitude = 106.7947351;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  CoronaChangeNotifier coronaProvider;
  String _mapStyle;
  GoogleMapController mapController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    coronaProvider = Provider.of<CoronaChangeNotifier>(context);
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/config/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mapController != null && coronaProvider.latLngBounds != null) {
      mapController.animateCamera(
          CameraUpdate.newLatLngBounds(coronaProvider.latLngBounds, 40.0));
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:16.0,right: 16.0),
            child: HeaderApp('Peta'),
          ),
          SizedBox(
            height: Sizes.height(context) * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.only(left:16.0,right: 16.0),
            child: CustomChipRange(),
          ),
          SizedBox(
            height: Sizes.height(context) * 0.015,
          ),
          coronaProvider.isFetching
              ? Center(
                  child: Loading(
                    indicator: BallSpinFadeLoaderIndicator(),
                    size: 50.0,
                    color: ColorPalette.grey,
                  ),
                )
              : Expanded(
                  child: GoogleMap(
                    mapToolbarEnabled: false,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(MapPage.latitude, MapPage.longitude),
                        zoom: 0.0),
                    mapType: MapType.normal,
                    markers: coronaProvider.marker,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      mapController.setMapStyle(_mapStyle);
                      mapController.animateCamera(CameraUpdate.newLatLngBounds(
                          coronaProvider.latLngBounds, 40.0));
                    },
                  ),
                )
        ],
      ),
    );
  }
}
