import 'dart:async';

import 'package:coronamonitorapps/commons/color_palletes.dart';
import 'package:coronamonitorapps/commons/image_asset.dart';
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

class DetailProvincePage extends StatelessWidget {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final coronaProvider = Provider.of<CoronaChangeNotifier>(context);
    final filterProv = Provider.of<RangeFilterChangeNotifier>(context);

    DateTime date = DateTime.now();

    var data = coronaProvider.coronaDetailProvince?.listCity;

    return Scaffold(
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
                      'Kalsel',
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
                  icKalsel,
                  width: Sizes.width(context) * 0.2,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
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

                          return item(context, itemCorona.nama, [
                            itemCorona.odp,
                            itemCorona.pdp,
                            itemCorona.positif,
                            itemCorona.negatif,
                            itemCorona.meninggal
                          ], [
                            ColorPalette.orangeStart,
                            ColorPalette.orangeEnd
                          ]);
                        }),
                  )
          ],
        ),
      ),
    );
  }

  Widget item(BuildContext context, String text, List<String> orang,
      List<Color> colors) {
    return Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: 5.0),
        width: Sizes.width(context),
//        height: Sizes.height(context) * 0.07,
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
            Text(
                'ODP: ${orang[0]}, ODP: ${orang[1]}\nPositif: ${orang[2]}, Sembuh: ${orang[3]}, Meninggal: ${orang[4]}',
                maxLines: 2
                ,style: GoogleFonts.poppins(
                    color: ColorPalette.white, fontSize: Sizes.dp12(context)))
//            RichText(
//              textAlign: TextAlign.left,
//              text: TextSpan(
//                  style: GoogleFonts.poppins(
//                      color: ColorPalette.white, fontSize: Sizes.dp10(context)),
//                  children: [
//                    TextSpan(
//                      text: 'ODP: ${orang[0]} ',
//                    ),
//                    TextSpan(
//                      text: 'ODP: ${orang[0]}',
//                    )
//                  ]),
//            ),
          ],
        ));
  }
}
