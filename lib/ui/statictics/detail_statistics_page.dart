import 'dart:async';

import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/sizes.dart';
import 'package:coronamonitorapps/const/app_constant.dart';
import 'package:coronamonitorapps/notifiers/corona_change_notifier.dart';
import 'package:coronamonitorapps/notifiers/range_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indonesia/indonesia.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class DetailStatisticsPage extends StatelessWidget {
  final String title, image;
  final List<Color> colors;

  DetailStatisticsPage(this.title, this.image, this.colors);

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final coronaProvider = Provider.of<CoronaChangeNotifier>(context);
    final filterProv = Provider.of<RangeFilterChangeNotifier>(context);

    var data;

    if (filterProv.selectedRangeChoice == 'Global') {
      data = coronaProvider.coronaGlobal?.listGlobal;
    } else if (filterProv.selectedRangeChoice == 'Indonesia') {
      data = coronaProvider.coronaIndo?.listProvince;
    } else {
      data = coronaProvider.coronaDetailProvince?.listCity;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        coronaProvider.loop = 1;
        if (_controller.text.isNotEmpty) {
          Timer(Duration(seconds: 1), () {
            coronaProvider.resetItemSearch(filterProv.selectedRangeChoice);
          });
        }
        return null;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  tanggal(date),
                  style: GoogleFonts.poppins(
                      color: ColorPalette.grey, fontSize: Sizes.dp12(context)),
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorPalette.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
                coronaProvider.loop = 1;
                if (_controller.text.isNotEmpty) {
                  Timer(Duration(seconds: 1), () {
                    coronaProvider
                        .resetItemSearch(filterProv.selectedRangeChoice);
                  });
                }
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                              color: ColorPalette.grey,
                              fontSize: Sizes.dp36(context),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppConst.appName,
                          style: GoogleFonts.poppins(
                              color: ColorPalette.grey,
                              fontSize: Sizes.dp16(context)),
                        ),
                      ],
                    ),
                    Image.asset(
                      image,
                      width: Sizes.width(context) * 0.2,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: Sizes.height(context) * 0.07,
                  child: TextField(
                    controller: _controller,
                    cursorColor: ColorPalette.grey,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Cari',
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorPalette.grey,
                        ),
                        fillColor: ColorPalette.greyInput,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none)),
                    onChanged: (String keyword) {
                      coronaProvider.searchCaseItemCorona(
                          keyword, filterProv.selectedRangeChoice);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                coronaProvider.isFetching
                    ? Center(
                        child: Loading(
                          indicator: BallSpinFadeLoaderIndicator(),
                          size: (Sizes.height(context) * 0.17) / 3,
                          color: ColorPalette.grey,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: data?.length ?? 0,
                            itemBuilder: (context, index) {
                              var itemCorona = data[index];
                              var jumlah;
                              switch (title) {
                                case 'Positif':
                                  jumlah =
                                      filterProv.selectedRangeChoice == 'Global'
                                          ? itemCorona.kasus
                                          : (filterProv.selectedRangeChoice ==
                                                  'Indonesia'
                                              ? itemCorona.kasus
                                              : itemCorona.positif);
                                  break;
                                case 'Sembuh':
                                  jumlah =
                                      filterProv.selectedRangeChoice == 'Global'
                                          ? itemCorona.sembuh
                                          : (filterProv.selectedRangeChoice ==
                                                  'Indonesia'
                                              ? itemCorona.sembuh
                                              : itemCorona.negatif);
                                  break;
                                case 'Meninggal':
                                  jumlah = itemCorona.meninggal;
                                  break;
                                case 'ODP':
                                  jumlah = itemCorona.odp;
                                  break;
                                case 'PDP':
                                  jumlah = itemCorona.pdp;
                                  break;
                              }
                              return item(
                                  context,
                                  filterProv.selectedRangeChoice == 'Global'
                                      ? itemCorona.negara
                                      : (filterProv.selectedRangeChoice ==
                                              'Indonesia'
                                          ? itemCorona.provinsi
                                          : itemCorona.nama),
                                  '$jumlah Org',
                                  colors);
                            }),
                      )
              ],
            ),
          )),
    );
  }

  Widget item(
      BuildContext context, String text, String orang, List<Color> colors) {
    return Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: 5.0),
        width: Sizes.width(context),
        height: Sizes.height(context) * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: colors,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text,
                style: GoogleFonts.poppins(
                    color: ColorPalette.white, fontSize: Sizes.dp16(context))),
            Text(orang,
                style: GoogleFonts.poppins(
                    color: ColorPalette.white, fontSize: Sizes.dp16(context))),
          ],
        ));
  }
}
